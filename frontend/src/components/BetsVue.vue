<template>
  <v-app id="inspire">
    <v-system-bar app>
    </v-system-bar>
    <v-navigation-drawer v-model="drawer" app>
      <v-sheet color="grey lighten-4" class="pa-4">
        <v-avatar class="mb-4" color="primary" size="64"> </v-avatar>
        <div class="infor"> {{ infor }} </div>
        <div class="infor">My Score: {{ myScore }}</div>
      </v-sheet>
      <Header />
    </v-navigation-drawer>
    <v-main>
      <v-container class="py-8 px-6" fluid>
        <v-card-title class="title"><h1>FootBall-Bets-FBiz (choose Home team Win - Draw - Lose)</h1> </v-card-title>
      </v-container>
      <v-simple-table>
        <template v-slot:default class="elevation-20">
          <thead>
          <tr>
            <th class="text-center">Date_Time</th>
            <th class="text-center">Home_Team</th>
            <th class="text-center"></th>
            <th class="text-center">Away_Team</th>
            <th class="text-center">You Choose</th>
          </tr>
          </thead>
          <tbody>
          <tr
              v-for="item in desserts"
              :key="item.username"
              class="text-center"
              v-if="item.goal === '-' "
              v-bind:class="{first: (item.goal === '-')}">
            <td>{{ item.date_time }}</td>
            <td>{{ item.home_team }}</td>
            <td>{{ item.goal }}</td>
            <td>{{ item.away_team }}</td>
            <td> <v-select v-model="item.choose"  :items="items"
                                color="#f5125f" persistent-hint return-object single-line
                                class="select"
                                @input = "save(item)" ></v-select>
            </td>
          </tr>
          <v-snackbar v-model="snack" :timeout="3000" :color="snackColor">
              <v-icon>{{ iconSuccess }}</v-icon> {{ snackText }}
          </v-snackbar>
          </tbody>
        </template>

      </v-simple-table>
      <v-container class="py-8 px-6" fluid>
        <v-row>
          <v-app-bar app>
            <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
            <v-toolbar-title>FootBall Bets</v-toolbar-title>
          </v-app-bar>
        </v-row>
      </v-container>
    </v-main>

  </v-app>
</template>

<script>

import api from "@/plugins/url";
import Header from "@/components/Header";
export default {
  name: "BetVue",
  data: () => ({
    drawer: null,
    infor: localStorage.email,
    myScore: localStorage.score,
    items:['W', "D", "L"],
    idUser: localStorage.id,
    iconSuccess: 'mdi-check-circle',
    snack: false,
    snackColor: '',
    snackText: '',
    desserts: [],
    editedIndex: -1,
    dataHistory: [],
    userBets: {
      match_number: undefined,
      date_time: undefined,
      home_team: undefined,
      away_team: undefined,
      id_match: undefined,
      email: localStorage.email,
      username: localStorage.name,
      choose: undefined,
      time_choose: undefined,
      id_user: undefined
    }
  }),

  computed: {
    headers() {
      return [
        {text: "Home_Team", value: 'home_team'},
        {text: "Goal", value: 'goal'},
        {text: "Away_Team", value: 'away_team'},
        {text: "Group_Match", value: 'group_match'},
        {text: "Result", value: 'result'},
        {text: "Choose", value: 'choose'},
      ]
    },
  },
  components:{
    Header
  },
  methods: {
    close() {
      const self = this
      self.$nextTick(() => {
        self.editedIndex = -1
      })
    },
    async save(item) {
      const self = this
      self.snack = true
      self.snackColor = 'success'
      self.snackText = 'Bets Success'
      self.userBets.away_team = item.away_team
      self.userBets.home_team = item.home_team
      self.userBets.date_time = item.date_time
      self.userBets.match_number = item.match_number
      self.userBets.id_match = item.id
      self.userBets.choose = item.choose.toUpperCase()
      self.userBets.score = 0
      self.userBets.id_user = localStorage.id
      self.userBets.time_choose = new Date().toLocaleString()
      await api.put('/api/users/bets', this.userBets)
      self.close()
    },
    async dessertsIt() {
      const self = this
      await api.get('/api/users/history/' + self.idUser).then(response_history => {
        self.dataHistory = response_history.data
      })
      await api.get('/api/match').then(response => {
        const self = this
        self.desserts = response.data
        self.desserts.sort(this.compareId)
        for (let i = 0; i < this.desserts.length; i++) {
          for (let j = 0; j < this.dataHistory.length; j++) {
            if (self.desserts.at(i).id === self.dataHistory.at(j).id_match) {
              self.desserts.at(i).choose = self.dataHistory.at(j).choose
            }}}
      })
    },
    compareId(a, b) {
      const scoreA = a.id;
      const scoreB = b.id;
      let comparison = 0;
      if (scoreA > scoreB) {
        comparison = 1;
      } else if (scoreA < scoreB) {
        comparison = -1;
      }
      return comparison
    },
  },
  beforeMount() {
    const self = this
    self.dessertsIt()
  }
}
</script>
<style rel="stylesheet/scss" lang="scss" scoped>
@import "src/assets/main.scss";
</style>
