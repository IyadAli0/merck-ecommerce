from app.models import Product, CartItem, Order


class EcommerceStore:
    def __init__(self):
        self.products = {
            1: Product(
                id=1,
                name="Vitamin C",
                description="Vitamin C supplement",
                price=120.0,
                category="Supplements",
            ),
            2: Product(
                id=2,
                name="Laboratory Gloves",
                description="Protective laboratory gloves",
                price=250.0,
                category="Lab Equipment",
            ),
            3: Product(
                id=3,
                name="Digital Thermometer",
                description="Precision digital thermometer",
                price=180.0,
                category="Medical Equipment",
            ),
            4: Product(
                id=4,
                name="Safety Goggles",
                description="Protective laboratory goggles",
                price=90.0,
                category="Safety",
            ),
            5: Product(
                id=5,
                name="Microscope Slides",
                description="Pack of microscope slides",
                price=150.0,
                category="Lab Equipment",
            ),
        }

        self.cart: dict[int, int] = {}
        self.orders: list[Order] = []
        self.next_order_id = 1

    def get_products(self):
        return list(self.products.values())

    def get_product(self, product_id: int):
        return self.products.get(product_id)

    def add_to_cart(self, product_id: int, quantity: int):
        self.cart[product_id] = self.cart.get(product_id, 0) + quantity

    def remove_from_cart(self, product_id: int):
        self.cart.pop(product_id, None)

    def get_cart(self):
        items = []

        for product_id, quantity in self.cart.items():
            product = self.products[product_id]

            items.append(
                CartItem(
                    product_id=product_id,
                    name=product.name,
                    quantity=quantity,
                    unit_price=product.price,
                    subtotal=round(product.price * quantity, 2),
                )
            )

        total = round(sum(item.subtotal for item in items), 2)

        return {
            "items": items,
            "total": total,
        }

    def checkout(self):
        cart = self.get_cart()

        if not cart["items"]:
            return None

        order = Order(
            order_id=self.next_order_id,
            items=cart["items"],
            total=cart["total"],
        )

        self.orders.append(order)
        self.next_order_id += 1
        self.cart.clear()

        return order


store = EcommerceStore()
