import Vue from 'vue/dist/vue';
import VueRouter from 'vue-router/dist/vue-router';

Vue.use(VueRouter);

export default new VueRouter({
  mode: "history",

  routes: [
    {
      path: '/',
      name: 'dashboard',
      meta: { layout: "default" },
      component: require("@/../views/dashboard_overview.vue").default
    }
  ]
})
