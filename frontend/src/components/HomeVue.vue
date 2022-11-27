<template>
  <v-app id="inspire">
    <v-system-bar app>
    </v-system-bar>
    <v-navigation-drawer
        v-model="drawer" app>
      <v-sheet
          color="grey lighten-4" class="pa-4">
        <v-avatar
            class="mb-4" color="primary" size="64"
        ></v-avatar>
        <div class="infor">{{ infor }}</div>
        <div class="infor">My Score: {{ myScore }}</div>
      </v-sheet>
      <v-divider></v-divider>

      <v-list>
        <v-list-item
            v-for="[icon, text] in home" :key="icon"
            @click="homeVue">
          <v-icon>{{ icon }}</v-icon>
          <v-list-item-title>{{ text }}</v-list-item-title>
        </v-list-item>
        <v-list-item
            v-for="[icon, text] in bets" :key="icon"
            @click="bets_user">
          <v-icon>{{ icon }}</v-icon>
          <v-list-item-title>{{ text }}</v-list-item-title>
        </v-list-item>

        <v-list-item
            v-for="[icon, text] in rank" :key="icon" @click="rank_user">
          <v-icon>{{ icon }}</v-icon>
          <v-list-item-title>{{ text }}</v-list-item-title>
        </v-list-item>
        <v-list-item
            v-for="[icon, text] in historyBets" :key="icon" @click="history_bets">
          <v-icon>{{ icon }}</v-icon>
          <v-list-item-title>{{ text }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-main>
      <v-container
          class="py-8 px-6" fluid>
        <v-card-title class="title"> <h1>Lịch Thi Đấu World Cup</h1>
          <v-spacer></v-spacer>
          <v-text-field
              v-model="search" append-icon="mdi-magnify" label="Search" single-line hide-details
          ></v-text-field>
        </v-card-title>
        <v-row>
          <v-col>
            <v-data-table
                :headers="headers"
                :items="desserts"
                :search="search"
                item-key="name"
                class="elevation-15"
                v-bind:class="{home_vue:desserts.length > 0}">
              <template v-slot:item.result="props" v-if="role==='admin'">
                <v-edit-dialog :return-value.sync="props.item.result"
                               @save="save(props.item)"
                               @close="close">
                  {{ props.item.result }}
                  <template v-slot:input>
                    <v-text-field
                        v-model="props.item.result" counter label="Edit" single-line
                    ></v-text-field>
                  </template>
                </v-edit-dialog>

              </template>
              <template v-slot:item.goal="props" v-if="role==='admin'">
                <v-edit-dialog
                    :return-value.sync="props.item.goal"
                    @save="save(props.item)"
                    @close="close">
                  {{ props.item.goal }}
                  <template v-slot:input>
                    <v-text-field
                        v-model="props.item.goal" counter label="Edit" single-line
                    ></v-text-field>
                  </template>
                </v-edit-dialog>
              </template>

            </v-data-table>
            <v-snackbar
                v-model="snack" :timeout="3000" :color="snackColor">
              {{ snackText }}

              <template v-slot:action="{ attrs }">
                <v-btn
                    v-bind="attrs" text @click="snack">
                    Close
                </v-btn>
              </template>
            </v-snackbar>
          </v-col>
        </v-row>
      </v-container>
       <v-container
          class="py-8 px-6"
          fluid>
        <v-row >
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
// import loginVue from "@/components/LoginVue";
// import compareScore from "@/components/RankVue"

export default {
  data: () => ({
    drawer: null,
    bets: [['mdi-controller', 'Bets']],
    rank: [['mdi-send', 'Ranking']],
    home: [['mdi-home', 'Home']],
    historyBets: [['mdi-card-text', "History Bets"]],
    search: "",
    snack: false,
    snackColor: '',
    snackText: '',
    pagination: {},
    infor: localStorage.email,
    myScore: localStorage.score,
    role: localStorage.role,
    desserts: [],
    updateMyScore:{
      email: localStorage.email
    },
    getInfor:{
      email: localStorage.email,
      password: localStorage.password
    },
    updateScore:{
      result: undefined,
      match_number: undefined,
    }
  }),

  computed: {
    headers() {
      return [
        {text: "Match_Number", value: 'match_number'},
        {text: "Date_Time", value: 'date_time'},
        {text: "Location_Match", value: 'location_match'},
        {text: "Home_Team", value: 'home_team'},
        {text: "Goal", value: 'goal'},
        {text: "Away_Team", value: 'away_team'},
        {text: "Group_Match", value: 'group_match'},
        {text: "Result", value: 'result'},

      ]
    }
  },
  methods: {
    async save(data) {
      this.snack = true
      this.snackColor = 'success'
      this.snackText = 'Data saved'
      this.updateScore.result = data.result
      this.updateScore.match_number = data.match_number
       axios.patch('http://103.170.123.206:1600/api/match/update', data)
       axios.post("http://103.170.123.206:1600/api/users/score",this.updateScore)
      // console.log(data)

    },
    close() {
    },
    async dessertsIt() {
      await axios.get('http://103.170.123.206:1600/api/match').then(response => {
        this.desserts = response.data
        this.desserts.sort(this.compareId)
      })
       axios.patch('http://103.170.123.206:1600/api/users/update/score', this.updateMyScore)
      await axios.post('http://103.170.123.206:1600/api/users/info_one_user',this.getInfor).then(response =>{
        // console.log(response.data[0].score)
       localStorage.score = response.data[0].score
        // console.log(localStorage.score)
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
    history_bets(){
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
