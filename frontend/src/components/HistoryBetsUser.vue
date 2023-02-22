<template>
  <v-app id="inspire">
    <v-system-bar app></v-system-bar>
    <v-navigation-drawer v-model="drawer" app>
      <v-sheet color="grey lighten-4" class="pa-4">
        <v-avatar class="mb-4" color="primary" size="64"></v-avatar>
        <div class="infor">{{ infor }}</div>
        <div class="infor">My Score: {{ myScore }}</div>
      </v-sheet>
      <v-divider></v-divider>
      <Header/>
    </v-navigation-drawer>
    <v-main>
      <v-container class="py-8 px-6" fluid>
        <v-card-title class="title"><h1>Lịch sử đặt cược của {{ userName }} </h1>
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
              class="text-center"
              v-bind:class="{history_color: (desserts.length > 0)}">
            <td>{{ item.time_choose }}</td>
            <td>{{ item.date_time }}</td>
            <td>{{ item.home_team }}</td>
            <td>{{ item.away_team }}</td>
            <td>{{ item.choose }}</td>
            <td>{{ item.score }}</td>
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

import api from "@/plugins/url";
import Header from "@/components/Header";

export default {
  name: "HistoryVue",
  components: {Header},
  data: () => ({
    drawer: null,
    userName: localStorage.name,
    infor: localStorage.email,
    myScore: localStorage.score,
    desserts: [],
    idUser: localStorage.id,
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
    async dessertsHistory() {
       const self = this
      self.userName = self.$route.params.username
      if (typeof self.userName == 'undefined') {
        self.userName = localStorage.name
      }
      await api.get('/api/users/history/' + self.$route.params.id).then(response => {
        self.desserts = response.data
        self.desserts.sort(self.compareId)
      })
    },
    compareId(a, b) {
      const scoreA = a.id_match;
      const scoreB = b.id_match;
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
    self.dessertsHistory()
  }
}
</script>
<style rel="stylesheet/scss" lang="scss" scoped>
@import "src/assets/main.scss";
</style>
