import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ["cartItemTemplate", "cartItems"];

  initialize() {
    const cart = JSON.parse(localStorage.getItem("cart"));
    if (!cart) {
      return;
    }

    let total = 0;

    cart.forEach((element) => {
      const clonedTemplate =
        this.cartItemTemplateTarget.content.cloneNode(true);
      total += element.price * element.quantity;

      clonedTemplate.querySelector("#price").textContent = `$${
        element.price / 100
      }`;
      clonedTemplate.querySelector("#quantity").textContent = element.quantity;
      clonedTemplate.querySelector("#name").textContent = element.name;
      clonedTemplate.querySelector("#itemImage").src = element.image_url;

      const removeItemButton = clonedTemplate.querySelector("#removeItem");
      removeItemButton.value = JSON.stringify({
        id: element.id,
        size: element.size,
      });
      removeItemButton.addEventListener("click", this.removeFromCart);

      const div = document.createElement("div");
      div.classList.add("mt-2");
      div.innerText = `Item: ${element.name} - $${
        element.price / 100.0
      } - Size: ${element.size} - Quantity: ${element.quantity}`;

      const deleteButton = document.createElement("button");
      deleteButton.innerText = "Remove";

      deleteButton.value = JSON.stringify({
        id: element.id,
        size: element.size,
      });

      this.cartItemsTarget.appendChild(clonedTemplate);

      const totalEl = document.createElement("div");
      totalEl.innerText = `Total: $${total / 100.0}`;

      let totalContainer = document.getElementById("total");
      totalContainer.appendChild(totalEl);
    });
  }

  clear() {
    localStorage.removeItem("cart");
    window.location.reload();
  }

  removeFromCart(event) {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const values = JSON.parse(event.target.value);
    const { id, size } = values;

    const index = cart.findIndex(
      (item) => item.id === id && item.size === size
    );
    if (index >= 0) {
      cart.splice(index, 1);
    }
    localStorage.setItem("cart", JSON.stringify(cart));
    window.location.reload();
  }

  checkout() {
    const cart = JSON.parse(localStorage.getItem("cart"));
    const payload = {
      authenticity_token: "",
      cart: cart,
    };

    const csrfToken = document.querySelector("[name='csrf-token']").content;

    fetch("/checkout", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify(payload),
    }).then((response) => {
      if (response.ok) {
        response.json().then((body) => {
          window.location.href = body.url;
        });
      } else {
        response.json().then((body) => {
          const errorEl = document.createElement("div");
          errorEl.innerText = `There was an error processing your order. ${body.error}`;

          let errorContainer = document.getElementById("errorContainer");
          errorContainer.appendChild(errorEl);
        });
      }
    });
  }
}
