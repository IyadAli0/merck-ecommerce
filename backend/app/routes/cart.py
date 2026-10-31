from fastapi import APIRouter, HTTPException

from app.models import CartItemRequest
from app.store import store

router = APIRouter(prefix="/cart", tags=["Cart"])


@router.get("/")
def get_cart():
    return store.get_cart()


@router.post("/items", status_code=201)
def add_cart_item(item: CartItemRequest):
    if not store.get_product(item.product_id):
        raise HTTPException(status_code=404, detail="Product not found")

    store.add_to_cart(item.product_id, item.quantity)
    return store.get_cart()


@router.delete("/items/{product_id}")
def remove_cart_item(product_id: int):
    if product_id not in store.cart:
        raise HTTPException(status_code=404, detail="Cart item not found")

    store.remove_from_cart(product_id)
    return store.get_cart()


@router.post("/checkout")
def checkout():
    order = store.checkout()

    if not order:
        raise HTTPException(status_code=400, detail="Cart is empty")

    return order
