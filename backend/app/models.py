from pydantic import BaseModel, Field


class Product(BaseModel):
    id: int
    name: str
    description: str
    price: float = Field(gt=0)
    category: str


class CartItemRequest(BaseModel):
    product_id: int
    quantity: int = Field(default=1, gt=0)


class CartItem(BaseModel):
    product_id: int
    name: str
    quantity: int
    unit_price: float
    subtotal: float


class Cart(BaseModel):
    items: list[CartItem]
    total: float


class Order(BaseModel):
    order_id: int
    items: list[CartItem]
    total: float
    status: str = "confirmed"
