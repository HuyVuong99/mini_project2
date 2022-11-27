<template>
  <v-app id="inspire">
    <v-system-bar app>
    </v-system-bar>
    <v-navigation-drawer
        v-model="drawer"
        app>
      <v-sheet
          color="grey lighten-4"class="pa-4">
        <v-avatar
            class="mb-4" color="primary" size="64" ></v-avatar>
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
            @click="bets_user" >
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
        <v-card-title class="title"> <h1> Bảng xếp hạng</h1>
          <v-spacer></v-spacer>
        </v-card-title>
      </v-container>
      <v-simple-table
          class="elevation-20">
        <template v-slot:default>
          <thead>
          <tr>
            <th class="text-center">STT</th>
            <th class="text-center">Name</th>
            <th class="text-center">Score</th>
          </tr>
          </thead>
          <tbody>
          <tr
              v-for="(item, index) in desserts"
              :key="item.username"
              class="text-center"
              v-bind:class="{first_rank: index < 1, second_rank: index>0, third_rank: index>1 }">
            <td>{{ index + 1 }}</td>
            <td>{{ item.username }}</td>
            <td>{{ item.score }}</td>
          </tr>
          </tbody>
        </template>
      </v-simple-table>
      <v-container
          class="py-8 px-6"
          fluid>
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
// export default defineComponent({
//   setup(){
//     const headers = async () => {
//     const response= await axios.get('http://103.170.123.206:1600/matches')
//           console.log(response.data)
//     }
//     return [response]
//
//
//   }
// })
import axios from "axios";

export default {
  data: () => ({
    drawer: null,
    bets: [['mdi-controller', 'Bets']],
    rank: [['mdi-send', 'Ranking']],
    historyBets: [['mdi-card-text', "History Bets"]],
    infor: localStorage.email,
    myScore: localStorage.score,
    desserts: [],
    home: [['mdi-home', 'Home']],
  }),


  methods: {
    getUsers() {
      axios.get('http://103.170.123.206:1600/api/users').then(response => {
        // console.log(response.data)
        this.desserts = response.data
      }).catch(error => console.log(error))
    },
    // compareScore(a, b) {
    //   const scoreA = a.score;
    //   const scoreB = b.score;
    //   let comparison = 0;
    //   if (scoreA > scoreB) {
    //     comparison = 1;
    //   } else if (scoreA < scoreB) {
    //     comparison = -1;
    //   }
    //   return comparison
    // },
    rank_user() {
      this.$router.push('/ranking')
    },
    homeVue() {
      this.$router.push('/dashboard')
    },
    bets_user() {
      this.$router.push('/bets')
    },
    history_bets(){
      this.$router.push('/history')
    }
  },
  beforeMount() {
    this.getUsers()
  }
}

</script>
<style rel="stylesheet/scss" lang="scss" scoped>
@import "src/assets/main.scss";
</style>
