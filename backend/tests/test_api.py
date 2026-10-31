from fastapi.testclient import TestClient

from app.main import app
from app.store import store

client = TestClient(app)


def setup_function():
    store.cart.clear()
    store.orders.clear()
    store.next_order_id = 1


def test_health_check():
    response = client.get("/healthz")

    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}


def test_get_products():
    response = client.get("/products/")

    assert response.status_code == 200
    assert len(response.json()) == 5


def test_add_item_to_cart():
    response = client.post(
        "/cart/items",
        json={"product_id": 1, "quantity": 2},
    )

    assert response.status_code == 201

    cart = response.json()
    assert len(cart["items"]) == 1
    assert cart["items"][0]["quantity"] == 2
    assert cart["total"] == 240.0


def test_checkout_clears_cart():
    client.post(
        "/cart/items",
        json={"product_id": 1, "quantity": 2},
    )

    response = client.post("/cart/checkout")

    assert response.status_code == 200
    assert response.json()["status"] == "confirmed"

    cart_response = client.get("/cart/")
    assert cart_response.json()["items"] == []
    assert cart_response.json()["total"] == 0


def test_add_nonexistent_product():
    response = client.post(
        "/cart/items",
        json={"product_id": 999, "quantity": 1},
    )

    assert response.status_code == 404
