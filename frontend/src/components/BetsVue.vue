<template>
  <v-app id="inspire">
    <v-system-bar app>
    </v-system-bar>
    <v-navigation-drawer
        v-model="drawer"
        app>
      <v-sheet
          color="grey lighten-4" class="pa-4">
        <v-avatar
            class="mb-4" color="primary" size="64">
        </v-avatar>
        <div class="infor">
          {{ infor }}
        </div>
        <div class="infor">My Score: {{ myScore }}</div>
      </v-sheet>
      <v-list>
        <v-list-item
            v-for="[icon, text] in home"
            :key="icon"
            @click="homeVue">
          <v-icon>{{ icon }}</v-icon>
          <v-list-item-title>{{ text }}</v-list-item-title>
        </v-list-item>
        <v-list-item
            v-for="[icon, text] in bets"
            :key="icon"
            link>
          <v-icon>{{ icon }}</v-icon>
          <v-list-item-title>{{ text }}</v-list-item-title>
        </v-list-item>

        <v-list-item
            v-for="[icon, text] in rank"
            :key="icon"
            @click="rank_user">
          <v-icon>{{ icon }}</v-icon>
          <v-list-item-title>{{ text }}</v-list-item-title>
        </v-list-item>
        <v-list-item
            v-for="[icon, text] in historyBets"
            :key="icon"
            @click="history_bets">
          <v-icon>{{ icon }}</v-icon>
          <v-list-item-title>{{ text }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-main>
      <v-container
          class="py-8 px-6"
          fluid>
        <v-card-title class="title"><h1>FootBall-Bets-FBiz (choose Home team Win - Draw - Lose)</h1>
        </v-card-title>
      </v-container>
      <v-simple-table>
        <template v-slot:default
                  class="elevation-20">
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
            <td>
              <v-select v-model="item.choose"  :items="items"
                                color="#f5125f"
                                persistent-hint
                                return-object
                                single-line
                                class="select"
                                @input = "save(item)"
                                ></v-select>
            </td>
          </tr>
          <v-snackbar
              v-model="snack" :timeout="3000" :color="snackColor">
            <v-icon>{{ iconSuccess }}</v-icon>
            {{ snackText }}
          </v-snackbar>
          </tbody>
        </template>

      </v-simple-table>
      <v-container
          class="py-8 px-6" fluid>
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
export default {
  data: () => ({
    drawer: null,
    bets: [['mdi-controller', 'Bets']],
    rank: [['mdi-send', 'Ranking']],
    home: [['mdi-home', 'Home']],
    historyBets: [['mdi-card-text', "History Bets"]],
    infor: localStorage.email,
    myScore: localStorage.score,
    items:['W', "D", "L"],
    idUser: localStorage.id,
    iconSuccess: 'mdi-check-circle',
    snack: false,
    snackColor: '',
    snackText: '',
    desserts: [],
    edit: false,
    editedIndex: -1,
    editData: {},
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
    },
    dialog: false
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
  methods: {
    editItem(item) {
      this.editData = item
      this.dialog = true
    },
    close() {
      this.dialog = false
      this.$nextTick(() => {
        this.editedIndex = -1
      })
    },
    async save(item) {
      this.snack = true
      this.snackColor = 'success'
      this.snackText = 'Bets Success'
      this.userBets.away_team = item.away_team
      this.userBets.home_team = item.home_team
      this.userBets.date_time = item.date_time
      this.userBets.match_number = item.match_number
      this.userBets.id_match = item.id
      this.userBets.choose = item.choose.toUpperCase()
      this.userBets.score = 0
      this.userBets.id_user = localStorage.id
      this.userBets.time_choose = new Date().toLocaleString()
      await api.put('/api/users/bets', this.userBets)
      this.close()
    },
    async dessertsIt() {
      await api.get('/api/users/history/' + this.idUser).then(response_history => {
        this.dataHistory = response_history.data
      })
      await api.get('/api/match').then(response => {
        this.desserts = response.data
        this.desserts.sort(this.compareId)
        for (let i = 0; i < this.desserts.length; i++) {
          for (let j = 0; j < this.dataHistory.length; j++) {
            if (this.desserts.at(i).id === this.dataHistory.at(j).id_match) {
              this.desserts.at(i).choose = this.dataHistory.at(j).choose
            }
          }
        }
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
    homeVue() {
      this.$router.push('/dashboard')
    },
    rank_user() {
      this.$router.push('/ranking')
    },
    history_bets() {
      this.$router.push('/history/'+ localStorage.id)
    }
  },
  beforeMount() {
    this.dessertsIt()
  }
}
</script>
<style rel="stylesheet/scss" lang="scss" scoped>
@import "src/assets/main.scss";
</style>
