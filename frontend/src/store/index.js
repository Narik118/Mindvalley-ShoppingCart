// store.js
import { createStore } from 'vuex';
import axios from 'axios';

const store = createStore({
  state: {
    products: [],
    cartProducts: []
  },
  mutations: {
    setProducts(state, products) {
      state.products = products;
    },
    addToCart(state, product) {
      const existingProduct = state.cartProducts.find(p => p.id === product.id);
      if (existingProduct) {
        existingProduct.quantity++;
        existingProduct.total = existingProduct.price * existingProduct.quantity;
      } else {
        state.cartProducts.push({ ...product, quantity: 1, total: product.price });
      }
    },
    removeFromCart(state, product) {
      const index = state.cartProducts.findIndex(p => p.id === product.id);
      if (index !== -1) {
        state.cartProducts.splice(index, 1);
      }
    },
    clearCart(state) {
      state.cartProducts = [];
    },
    incrementQuantity(state, productId) {
      const product = state.cartProducts.find(p => p.id === productId);
      if (product) {
        product.quantity++;
        product.total = product.price * product.quantity;
      }
    },
    decrementQuantity(state, productId) {
      const product = state.cartProducts.find(p => p.id === productId);
      if (product) {
        if (product.quantity > 1) {
          product.quantity--;
          product.total = product.price * product.quantity;
        } else {
          state.cartProducts = state.cartProducts.filter(p => p.id !== productId);
        }
      }
    }
  },
  actions: {
    async fetchProducts({ commit }) {
      try {
        const apiUrl = 'http://localhost:4000/api/v1/inventory'; // Replace with your API endpoint
        const response = await axios.get(apiUrl);
        commit('setProducts', response.data.inventory);
      } catch (error) {
        console.error('Error fetching products:', error);
      }
    },
    addToCart({ commit }, product) {
      commit('addToCart', product);
    },
    removeFromCart({ commit }, product) {
      commit('removeFromCart', product);
    },
    clearCart({ commit }) {
      commit('clearCart');
    },
    incrementQuantity({ commit }, productId) {
      commit('incrementQuantity', productId);
    },
    decrementQuantity({ commit }, productId) {
      commit('decrementQuantity', productId);
    }
  },
  getters: {
    products: state => state.products,
    cartProducts: state => state.cartProducts
  }
});

export default store;
