import { createApp } from 'vue'
import App from './App.vue'
import router from './router';
import store from './store';
import { TransitionRoot } from '@headlessui/vue';


createApp(App).use(router).use(store).component('TransitionRoot', TransitionRoot).mount('#app')
