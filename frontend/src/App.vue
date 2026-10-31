
<script setup>
import { ref, onMounted } from 'vue'
import api from './services/api'

const products = ref([])
const cart = ref({ items: [], total: 0 })
const loading = ref(false)
const error = ref('')
const success = ref('')

async function loadProducts() {
  try {
    const response = await api.get('/products/')
    products.value = response.data
  } catch {
    error.value = 'Could not load products. Is the backend running?'
  }
}

async function loadCart() {
  try {
    const response = await api.get('/cart/')
    cart.value = response.data
  } catch {
    error.value = 'Could not load cart.'
  }
}

async function addToCart(productId) {
  error.value = ''
  success.value = ''

  try {
    const response = await api.post('/cart/items', {
      product_id: productId,
      quantity: 1,
    })
    cart.value = response.data
    success.value = 'Product added to cart!'
  } catch (err) {
    error.value = err.response?.data?.detail || 'Could not add product.'
  }
}

async function removeFromCart(productId) {
  error.value = ''
  success.value = ''

  try {
    const response = await api.delete(`/cart/items/${productId}`)
    cart.value = response.data
  } catch (err) {
    error.value = err.response?.data?.detail || 'Could not remove item.'
  }
}

async function checkout() {
  if (!cart.value.items.length) return

  loading.value = true
  error.value = ''
  success.value = ''

  try {
    const response = await api.post('/cart/checkout')
    cart.value = { items: [], total: 0 }
    success.value = `Order #${response.data.order_id} confirmed!`
  } catch (err) {
    error.value = err.response?.data?.detail || 'Checkout failed.'
  } finally {
    loading.value = false
  }
}

onMounted(async () => {
  await Promise.all([loadProducts(), loadCart()])
})
</script>

<template>
  <main class="container">
    <header>
      <div>
        <h1>Merck Store</h1>
        <p>Simple e-commerce demo</p>
      </div>
      <span class="cart-count">
        {{ cart.items.reduce((sum, item) => sum + item.quantity, 0) }} items
      </span>
    </header>

    <p v-if="error" class="message error">{{ error }}</p>
    <p v-if="success" class="message success">{{ success }}</p>

    <div class="layout">
      <section>
        <h2>Products</h2>

        <div class="products">
          <article v-for="product in products" :key="product.id" class="product">
            <span class="category">{{ product.category }}</span>
            <h3>{{ product.name }}</h3>
            <p>{{ product.description }}</p>
            <div class="product-footer">
              <strong>{{ product.price.toFixed(2) }} EGP</strong>
              <button @click="addToCart(product.id)">Add to cart</button>
            </div>
          </article>
        </div>
      </section>

      <aside class="cart">
        <h2>Your Cart</h2>

        <p v-if="!cart.items.length" class="empty">Your cart is empty.</p>

        <div v-for="item in cart.items" :key="item.product_id" class="cart-item">
          <div>
            <strong>{{ item.name }}</strong>
            <p>{{ item.quantity }} × {{ item.unit_price }} EGP</p>
          </div>
          <div class="item-actions">
            <strong>{{ item.subtotal }} EGP</strong>
            <button class="remove" @click="removeFromCart(item.product_id)">
              Remove
            </button>
          </div>
        </div>

        <div class="total">
          <strong>Total</strong>
          <strong>{{ cart.total.toFixed(2) }} EGP</strong>
        </div>

        <button
          class="checkout"
          :disabled="!cart.items.length || loading"
          @click="checkout"
        >
          {{ loading ? 'Processing...' : 'Checkout' }}
        </button>
      </aside>
    </div>
  </main>
</template>

<style>
* {
  box-sizing: border-box;
}

body {
  margin: 0;
  font-family: Arial, sans-serif;
  background: #f5f6f8;
  color: #20242a;
}

button {
  border: 0;
  border-radius: 6px;
  padding: 10px 14px;
  background: #087b65;
  color: white;
  cursor: pointer;
}

button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.container {
  max-width: 1100px;
  margin: 40px auto;
  padding: 0 20px;
}

header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30px;
}

header h1 {
  margin-bottom: 5px;
}

header p, .product p, .cart-item p {
  color: #69717d;
}

.cart-count, .category {
  background: #e5f3ef;
  color: #087b65;
  padding: 7px 12px;
  border-radius: 20px;
  font-size: 13px;
}

.layout {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 25px;
}

.products {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 16px;
}

.product, .cart {
  background: white;
  border-radius: 10px;
  padding: 20px;
  border: 1px solid #e7e9ed;
}

.product h3 {
  margin-bottom: 8px;
}

.product-footer, .total, .cart-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
}

.cart {
  align-self: start;
}

.cart-item {
  padding: 15px 0;
  border-bottom: 1px solid #eee;
}

.item-actions {
  text-align: right;
}

.remove {
  display: block;
  margin-top: 8px;
  background: #fcebea;
  color: #b42318;
}

.total {
  padding: 20px 0;
  font-size: 18px;
}

.checkout {
  width: 100%;
}

.empty {
  color: #69717d;
  padding: 20px 0;
}

.message {
  padding: 12px;
  border-radius: 6px;
}

.error {
  background: #fcebea;
  color: #b42318;
}

.success {
  background: #e5f3ef;
  color: #087b65;
}

@media (max-width: 700px) {
  .layout {
    grid-template-columns: 1fr;
  }

  .products {
    grid-template-columns: 1fr;
  }
}
</style>
