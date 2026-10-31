from fastapi import APIRouter, HTTPException

from app.store import store

router = APIRouter(prefix="/products", tags=["Products"])


@router.get("/")
def get_products():
    return store.get_products()


@router.get("/{product_id}")
def get_product(product_id: int):
    product = store.get_product(product_id)

    if not product:
        raise HTTPException(status_code=404, detail="Product not found")

    return product
