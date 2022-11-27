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
        <div class="infor">{{ infor }}</div>
        <div class="infor">My Score: {{ myScore }}</div>
      </v-sheet>
      <v-divider></v-divider>
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
            @click="bets_user">
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
        <!--        <v-list-item-->
        <!--            v-for="[icon, text] in historyBets"-->
        <!--            :key="icon"-->
        <!--            @click="rank_user">-->
        <!--          <v-icon>{{ icon }}</v-icon>-->
        <!--          <v-list-item-title>{{ text }}</v-list-item-title>-->
        <!--        </v-list-item>-->
      </v-list>
    </v-navigation-drawer>
    <v-main>
      <v-container
          class="py-8 px-6"
          fluid>
        <v-card-title class="title"> <h1>History My Bets</h1>
          <v-spacer></v-spacer>
        </v-card-title>
      </v-container>
      <v-simple-table>
        <template v-slot:default
                  class="elevation-20">
          <thead>
          <tr>
            <th class="text-center">Time_Choose</th>
            <th class="text-center">Date_Time</th>
            <th class="text-center">Home_Team</th>
            <th class="text-center">Away_Team</th>
            <th class="text-center">Choose</th>
            <th class="text-center">Score</th>
          </tr>
          </thead>
          <tbody>
          <tr
              v-for="(item) in desserts"
              :key="item.username"
              class="text-center"
              v-bind:class="{history_color: (desserts.length > 0)}">
            <td>{{ item.time_choose }}</td>
            <td>{{ item.date_time }}</td>
            <td>{{ item.home_team }}</td>
            <td>{{ item.away_team }}</td>
            <td>{{ item.choose }}</td>
            <td>{{item.score}}</td>
          </tr>
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

import axios from "axios";

export default {
  data: () => ({
    drawer: null,
    bets: [['mdi-controller', 'Bets']],
    rank: [['mdi-send', 'Ranking']],
    home: [['mdi-home', 'Home']],
    historyBets: [['mdi-card-text', "History Bets"]],
    infor: localStorage.email,
    myScore: localStorage.score,
    desserts: [],
    edit: false,
    editedIndex: -1,
    editData: {},
    dataHistory: [],
    emailUser: {
      email: undefined
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
    async dessertsIt() {
      this.emailUser.email = localStorage.email
      await axios.post('http://103.170.123.206:1600/api/users/history',this.emailUser).then(response=>{
        this.desserts = response.data
        // console.log(response.data)
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
    bets_user() {
      this.$router.push('/bets')
    },
    history_bets() {
      this.$router.push('/history')
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
