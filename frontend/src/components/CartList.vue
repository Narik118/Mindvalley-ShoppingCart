<template>
    <div class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center">
      <div class="bg-white p-6 max-w-lg mx-auto rounded-lg shadow-lg">
        <h2 class="text-xl font-semibold mb-4">Shopping Cart</h2>
        <div v-if="cartProducts.length === 0" class="text-gray-600">Your cart is empty.</div>
        <div v-else>
          <div v-for="product in cartProducts" :key="product.id" class="flex items-center justify-between mb-4">
            <div class="flex items-center space-x-4">
              <!-- Image Container -->
              <div class="w-16 h-16">
                <img :src="product.product_image" :alt="product.imageAlt" class="w-full h-full object-contain rounded-md border border-gray-200">
              </div>
              <div>
                <p class="text-lg font-medium text-gray-900 truncate">{{ product.name }}</p>
                <p class="text-sm text-gray-500">Price: {{ product.price }}</p>
                <div class="flex items-center mt-1">
                  <!-- Decrement Button -->
                  <button @click="decrementQuantity(product.id)" class="px-2 py-1 bg-gray-200 text-gray-600 rounded-md hover:bg-gray-300">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M8 10a2 2 0 0 1 0-4h8a2 2 0 0 1 0 4H8z"/>
                    </svg>
                  </button>
                  <!-- Quantity Display -->
                  <span class="text-lg font-semibold mx-2">{{ product.quantity }}</span>
                  <!-- Increment Button -->
                  <button @click="incrementQuantity(product.id)" class="px-2 py-1 bg-gray-200 text-gray-600 rounded-md hover:bg-gray-300">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M12 8a2 2 0 1 1-4 0 2 2 0 0 1 4 0zm-4 0a4 4 0 1 0 8 0 4 4 0 0 0-8 0z"/>
                    </svg>
                  </button>
                </div>
              </div>
            </div>
            <div>
              <p class="text-sm text-gray-500">Total: ${{ calculateTotal(product) }}</p>
            </div>
          </div>
          <div class="flex justify-between mt-6">
            <p class="text-lg font-semibold">Subtotal:</p>
            <p class="text-lg font-semibold">${{ calculateSubtotal() }}</p>
          </div>
          <div class="mt-6 flex justify-center">
            <button @click="checkout" class="px-6 py-2 bg-gradient-to-r from-purple-600 to-indigo-600 text-white rounded-lg shadow-md hover:bg-gradient-to-r hover:from-purple-700 hover:to-indigo-700">Checkout</button>
          </div>
        </div>
        <button @click="$emit('closeCartPanel')" class="close-btn absolute top-4 right-4 text-gray-700 hover:text-gray-900">
          <svg class="w-6 h-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>
    </div>
  </template>

<script>
import { mapGetters } from 'vuex';

export default {
  props: ['cartProducts', 'calculateSubtotal', 'calculateTotal'],
  computed: {
    ...mapGetters(['cartProducts'])
  },
  methods: {
    decrementQuantity(productId) {
      this.$emit('decrementQuantity', productId);
    },
    incrementQuantity(productId) {
      this.$emit('incrementQuantity', productId);
    },
    checkout() {
      this.$emit('checkout');
    }
  }
};
</script>
  
<style scoped>
.close-btn:hover {
  color: #ef540c;
}

.close-btn {
  color: aliceblue;
}

.close-btn:hover svg {
  stroke: #cc1818;
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
