<template>
  <v-app id="inspire">
    <v-system-bar app> </v-system-bar>
    <v-navigation-drawer v-model="drawer" app>
      <v-sheet color="grey lighten-4" class="pa-4">
        <v-avatar class="mb-4" color="primary" size="64" ></v-avatar>
        <div class="infor">{{ infor }}</div>
        <div class="infor">My Score: {{ myScore }}</div>
      </v-sheet>
      <Header />
    </v-navigation-drawer>
    <v-main>
      <v-container class="py-8 px-6" fluid>
        <v-card-title class="title"> <h1>Lịch Thi Đấu World Cup</h1>
           <v-spacer></v-spacer>
          <v-text-field v-model="search" append-icon="mdi-magnify" label="Search" single-line hide-details ></v-text-field>
        </v-card-title>
        <v-row>
          <v-col>
            <v-data-table
                :headers="headers" :items="desserts" :search="search" item-key="name" class="elevation-15"
                v-bind:class="{home_vue:desserts.length > 0}">
              <template v-slot:item.result="props" v-if="role==='admin'">
                <v-edit-dialog :return-value.sync="props.item.result"
                               @save="save(props.item)" @close="close"> {{ props.item.result }}
                  <template v-slot:input>
                    <v-text-field v-model="props.item.result" counter label="Edit" single-line ></v-text-field>
                  </template>
                </v-edit-dialog>
              </template>
              <template v-slot:item.goal="props" v-if="role==='admin'">
                <v-edit-dialog :return-value.sync="props.item.goal" @save="save(props.item)" @close="close">
                  {{ props.item.goal }}
                  <template v-slot:input>
                    <v-text-field
                        v-model="props.item.goal" counter label="Edit" single-line
                    ></v-text-field>
                  </template>
                </v-edit-dialog>
              </template>

            </v-data-table>
            <v-snackbar v-model="snack" :timeout="3000" :color="snackColor"> {{ snackText }}
              <template v-slot:action="{ attrs }">
                <v-btn v-bind="attrs" text @click="snack"> Close </v-btn>
              </template>
            </v-snackbar>
          </v-col>
        </v-row>
      </v-container>
       <v-container class="py-8 px-6" fluid>
        <v-row>
          <v-app-bar app> <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
            <v-toolbar-title>FootBall Bets</v-toolbar-title>
          </v-app-bar>
        </v-row>
      </v-container>
    </v-main>

  </v-app>
</template>

<script>

import api from '../plugins/url'
import Header from "@/components/Header";
export default {
  name: "HomeFootBall",
  components: {Header},
  data: () => ({
    drawer: null,
    search: "", snack: false, snackColor: '', snackText: '',
    infor: localStorage.email,
    myScore: localStorage.score,
    role: localStorage.role,
    desserts: [],
    getInfor:{
      email: localStorage.email,
      password: localStorage.password
    },
    updateScore:{
      result: undefined,
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
      await api.patch('/api/match/update', data)
      await api.patch("/api/users/score/"+ data.match_number,this.updateScore)
    },
    close() {
    },
    async dessertsIt() {
      await api.get('/api/match').then(response => {
        this.desserts = response.data
        this.desserts.sort(this.compareId)
      })
      await api.patch('/api/users/update/score/'+localStorage.id)
      await api.post('/api/users/info_one_user',this.getInfor).then(response =>{
       localStorage.score = response.data[0].score
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
    this.dessertsIt() }
}

</script>
<style rel="stylesheet/scss" lang="scss" scoped>
@import "src/assets/main.scss";
</style>
