from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.routes import products, cart

app = FastAPI(
    title="Merck E-Commerce API",
    description="E-commerce platform assessment",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(products.router)
app.include_router(cart.router)


@app.get("/healthz")
def health_check():
    return {"status": "healthy"}
