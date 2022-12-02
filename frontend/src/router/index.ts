import Vue from 'vue'
import VueRouter from 'vue-router'
import LoginView from '../views/LoginView.vue'
import RankView from "@/views/RankView.vue";
import HomeFootBallView from "@/views/HomeFootBallView.vue";
import historyView from "@/views/HistoryView.vue";


Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'LoginView',
    component: LoginView
  },

    {
    path: '/dashboard',
    name: 'Dashboard',
    component: HomeFootBallView
  },
  {
    path: '/ranking',
    name: 'Ranking',
    component: RankView
  },
    {
    path: '/history/:id',
    name: 'History',
    component: historyView
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
