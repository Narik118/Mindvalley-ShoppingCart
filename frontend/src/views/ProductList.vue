<template>
  <div>
    <!-- Product List -->
    <h1 class="text-2xl font-semibold mb-4">Product List</h1>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <ProductCard
        v-for="product in products"
        :key="product.id"
        :product="product"
        @addToCart="addToCart"
        class="hover:shadow-md hover:scale-105 transition-transform duration-300"
      />
    </div>

    <!-- Cart button -->
    <button @click="showCartPanel = true" class="fixed top-2 right-4 px-4 py-2 bg-gradient-to-r from-white to-purple-600 text-black-800 rounded-lg shadow-md hover:bg-gradient-to-r hover:from-white hover:to-purple-700">
      View Cart ({{ cartProducts.length }})
    </button>

    <!-- Cart panel -->
    <Cart v-if="showCartPanel"
         :cartProducts="cartProducts"
         @closeCartPanel="showCartPanel = false"
         @checkout="checkout"
         @decrementQuantity="decrementQuantity"
         @incrementQuantity="incrementQuantity"
         @clearCart="clearCart"
         :calculateSubtotal="calculateSubtotal"
         :calculateTotal="calculateTotal"
    />

    <!-- Toast Component for Notifications -->
    <Toast v-if="checkoutSuccess" message="Checkout successful! Thank you for your purchase." variant="success" />
    <Toast v-if="checkoutError" :message="checkoutErrorMessage" variant="error" />

  </div>
</template>

<script>
import ProductCard from '@/components/ProductCard.vue';
import Cart from '@/components/CartList.vue';
import Toast from '@/components/ToastMessage.vue';
import { mapActions, mapGetters } from 'vuex';
import axios from 'axios';

export default {
  components: {
    ProductCard,
    Cart, // Register Cart component
    Toast,
  },
  computed: {
    ...mapGetters(['products', 'cartProducts'])
  },
  methods: {
    ...mapActions(['fetchProducts', 'addToCart', 'removeFromCart', 'clearCart', 'incrementQuantity', 'decrementQuantity']),
    calculateSubtotal() {
      return this.cartProducts.reduce((total, product) => {
        return total + parseFloat(product.price.replace('$', '')) * product.quantity;
      }, 0).toFixed(2);
    },
    calculateTotal(product) {
      if (product && product.price) {
        const totalPrice = parseFloat(product.price.replace('$', '')) * product.quantity;
        return totalPrice.toFixed(2);
      }
      return '0.00';
    },
    checkout() {
      const checkoutData = this.cartProducts.map(product => {
        return {
          id: product.id,
          price: product.price,
          quantity: product.quantity
        };
      });

      this.postCheckoutData(checkoutData);
    },
    postCheckoutData(data) {
      const apiUrl = 'http://localhost:4000/api/v1/checkout';
      axios.put(apiUrl, data)
        .then(response => {
          console.log('Checkout successful:', response.data);
          this.clearCart();
          this.showCartPanel = false;
          this.showCheckoutSuccess();
        })
        .catch(error => {
          console.error('Error during checkout:', error.response.data);
          this.showCheckoutError(error.response.data.error || error.message || 'Checkout failed. Please try again.');
        });
    },
    showCheckoutSuccess() {
      this.checkoutSuccess = true;
      setTimeout(() => {
        this.dismissSuccess();
      }, 3000); // Auto dismiss after 3 seconds
    },
    dismissSuccess() {
      this.checkoutSuccess = false;
    },
    showCheckoutError(errorMessage) {
      this.checkoutError = true;
      this.checkoutErrorMessage = errorMessage;
      setTimeout(() => {
        this.dismissError();
      }, 3000); // Auto dismiss after 3 seconds
    },
    dismissError() {
      this.checkoutError = false;
      this.checkoutErrorMessage = '';
    },
    decrementQuantity(productId) {
      this.$store.dispatch('decrementQuantity', productId);
    },
    incrementQuantity(productId) {
      this.$store.dispatch('incrementQuantity', productId);
    }
  },
  data() {
    return {
      showCartPanel: false,
      checkoutSuccess: false,
      checkoutError: false,
      checkoutErrorMessage: ''
    };
  },
  created() {
    this.fetchProducts();
  }
};
</script>

<style scoped>
h1 {
  text-align: center;
  margin-top: 20px;
  margin-bottom: 20px;
  font-family: 'Grotesk-Bold', serif;
  color: #333;
}

.close-btn:hover {
  color: #ef540c;
}

.close-btn {
  color: aliceblue;
}

.close-btn:hover svg {
  stroke: #cc1818;
}

button[disabled] {
  cursor: not-allowed;
  opacity: 0.5;
}

.text-lg {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  max-width: 10rem; 
  font-size: 1rem;
}

.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter, .fade-leave-to {
  opacity: 0;
}

/* Additional CSS for image container */
.w-16.h-16 {
  width: 4rem; /* Adjust as needed */
  height: 4rem; /* Adjust as needed */
}
</style>
