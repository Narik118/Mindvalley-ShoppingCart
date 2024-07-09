<!-- Toast.vue -->
<template>
    <transition name="fade">
      <div v-if="visible" :class="['toast', variant]">
        <p>{{ message }}</p>
        <button @click="dismiss" class="close-btn">
          <svg class="w-4 h-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>
    </transition>
  </template>
  
  <script>
  export default {
    props: {
      message: String,
      variant: {
        type: String,
        default: 'success', // default variant
      },
    },
    data() {
      return {
        visible: true,
      };
    },
    methods: {
      dismiss() {
        this.visible = false;
      },
    },
  };
  </script>
  
  <style scoped>
  .toast {
    position: fixed;
    bottom: 1rem;
    right: 1rem;
    background-color: #333;
    color: white;
    padding: 1rem;
    border-radius: 0.5rem;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  }
  .toast.success {
    background-color: #4caf50;
  }
  .toast.error {
    background-color: #f44336;
  }
  .close-btn {
    cursor: pointer;
    color: white;
    background: none;
    border: none;
    outline: none;
  }
  </style>
  