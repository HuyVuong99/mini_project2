import Vue from 'vue'
import VueRouter from 'vue-router'
import LoginView from '../views/LoginView.vue'


Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'LoginView',
    component: () => import('../components/LoginVue.vue')
  },

    {
    path: '/dashboard',
    name: 'Dashboard',
    component: () => import('../components/HomeVue.vue')
  },
  {
    path: '/ranking',
    name: 'Ranking',
    component: () => import('../components/RankVue.vue')
  },
    {
    path: '/bets',
    name: 'Bets',
    component: () => import('../components/BetsVue.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
