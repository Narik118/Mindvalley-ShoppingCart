<template>
  <div class="ProductCard">
    <img :src="product.product_image" :alt="product.name" class="w-full h-auto object-contain">
    <div class="p-4">
      <h3 class="text-lg font-semibold">{{ product.name }}</h3>
      <p class="text-sm text-gray-800">${{ product.price }}</p>
      <button 
        @click="handleAddToCart"
        :class="{
          'bg-gradient-to-r from-green-400 to-purple-600 hover:from-green-600 hover:to-purple-800': addedToCart,
          'bg-indigo-600 hover:bg-indigo-700': !addedToCart
        }"
        class="mt-2 px-4 py-2 text-white rounded-lg shadow-md focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-opacity-50 relative"
      >
        <span>Add to Cart</span>
        <span v-if="addedToCart" class="absolute top-0 right-0 -mt-2 -mr-2 bg-green-600 text-white px-2 py-1 rounded-full text-xs font-semibold">Added</span>
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    product: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      addedToCart: false
    };
  },
  methods: {
    handleAddToCart() {
      if (!this.addedToCart) {
        this.addedToCart = true;
        this.$emit('addToCart', this.product);
      }
    }
  }
};
</script>

<style scoped>
.ProductCard {
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  overflow: hidden; 
}

.ProductCard img {
  height: 200px; 
}

/* Gradient styles for button */
.bg-gradient-to-r {
  transition: background-color 0.3s ease;
}
</style>
