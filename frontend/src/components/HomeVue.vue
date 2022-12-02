<template>
  <v-app id="inspire">
    <v-system-bar app></v-system-bar>
    <v-navigation-drawer v-model="drawer" app>
      <v-sheet color="grey lighten-4" class="pa-4">
        <v-avatar class="mb-4" color="primary" size="64"></v-avatar>
        <div class="infor">{{ infor }}</div>
        <div class="infor">My Score: {{ myScore }}</div>
      </v-sheet>
      <Header/>
    </v-navigation-drawer>
    <v-main>
      <v-container class="py-8 px-6" fluid>
        <v-card-title class="title"><h1>Lịch Thi Đấu World Cup</h1>
          <v-spacer></v-spacer>
          <v-text-field v-model="search" append-icon="mdi-magnify" label="Search" single-line
                        hide-details></v-text-field>
        </v-card-title>
        <v-row>
          <v-col>
            <v-data-table
                 :footer-props="{'items-per-page-options':[desserts.length],'disable-items-per-page': true,}"
                  :headers="headers" :items="desserts" :search="search" item-key="name"
                   v-bind:class="{ chooseMatch: (desserts.length>0)}">
              <template v-slot:item="props">
                <tr v-bind:class="{ matching: (props.item.result === '')}">
                  <td class=" math_number_color">{{ props.item.match_number }}</td>
                  <td>{{ props.item.date_time }}</td>
                  <td class="color_team">{{ props.item.home_team}}</td>
                  <td> {{ props.item.goal }}
                    <template v-if="role==='admin'">
                      <v-edit-dialog :return-value.sync="props.item.goal" @save="saveAdminChange(props.item)" @close="close">
                        <template v-slot:input>
                          <v-text-field v-model="props.item.goal" counter label="Edit" single-line ></v-text-field>
                        </template>
                      </v-edit-dialog>
                    </template></td>
                  <td class="color_team">{{ props.item.away_team }}</td>
                  <td>{{ props.item.group_match }}</td>
                  <td class="color_team"> {{props.item.result}}
                    <template v-if="role==='admin'">
                      <v-edit-dialog :return-value.sync="props.item.result"
                                     @save="saveAdminChange(props.item)" @close="close"> {{ props.item.result }}
                        <template v-slot:input>
                          <v-text-field v-model="props.item.result" counter label="Edit" single-line></v-text-field>
                        </template>
                      </v-edit-dialog>
                    </template> </td>
                  <td class="color_you_choose">
                    <template>
                      <v-select v-model="props.item.choose" :items="items"
                                color="#f5125f" persistent-hint return-object single-line
                                class="select"
                                v-bind:class="{ disabled: (props.item.goal !== '-')}"
                                @input="saveBets(props.item)"></v-select>
                    </template>
                  </td>
                  <td>{{ props.item.score }}</td>
                </tr>
              </template>
            </v-data-table>
            <v-snackbar v-model="snack" :timeout="3000" :color="snackColor"> {{ snackText }}
              <template v-slot:action="{ attrs }">
                <v-btn v-bind="attrs" text @click="snack"> Close</v-btn>
              </template>
            </v-snackbar>
          </v-col>
        </v-row>
      </v-container>
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

import api from '../plugins/url'
import Header from "@/components/Header";
import {all} from "core-js/internals/document-all";

export default {
  name: "HomeFootBall",
  components: {Header},
  data: () => ({
    idUser: localStorage.id,
    drawer: null,
    lock: false,
    items: ['W', "D", "L"],
    search: "", snack: false, snackColor: '', snackText: '',
    infor: localStorage.email,
    myScore: localStorage.score,
    role: localStorage.role,
    desserts: [],
    getInfor: {
      email: localStorage.email,
      password: localStorage.password
    },
    updateScore: {
      result: undefined,
    },
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
        {text: "Match_Number", value: 'match_number'},
        {text: "Date_Time", value: 'date_time'},
        {text: "Home_Team", value: 'home_team'},
        {text: "Goal", value: 'goal'},
        {text: "Away_Team", value: 'away_team'},
        {text: "Group_Match", value: 'group_match'},
        {text: "Result", value: 'result'},
        {text: "You Choose", value: 'choose'},
        {text: "You Score", value: 'score'},

      ]
    }
  },
  methods: {
    all() {
      return all
    },
    async saveAdminChange(data) {
      const self = this
      self.snack = true
      self.snackColor = 'success'
      self.snackText = 'Data saved'
      self.updateScore.result = data.result
      await api.patch('/api/match/update', data)
      await api.patch("/api/users/score/" + data.match_number, self.updateScore)
    },
    async saveBets(item) {
      const self = this
      self.snack = true
      self.snackColor = 'success'
      self.snackText = 'Bets Success'
      self.userBets.away_team = item.away_team
      self.userBets.home_team = item.home_team
      self.userBets.date_time = item.date_time
      self.userBets.match_number = item.match_number
      self.userBets.id_match = item.id
      self.userBets.choose = item.choose
      self.userBets.score = 0
      self.userBets.id_user = localStorage.id
      self.userBets.time_choose = new Date().toLocaleString()
      await api.put('/api/users/bets', this.userBets)
      self.close()
    },
    close() {
    },
    async dessertsIt() {
      const self = this
      await api.get('/api/match').then(response => {
        self.desserts = response.data
        self.desserts.sort(self.compareId)
      })
      await api.patch('/api/users/update/score/' + localStorage.id)
      await api.post('/api/users/info_one_user', self.getInfor).then(response => {
        localStorage.score = response.data[0].score
      })
    },
    async dataHistory() {
      const self = this
      await api.get('/api/users/history/' + self.idUser).then(response_history => {
        self.dataHistory = response_history.data
      })
      await api.get('/api/match').then(response => {
        console.log(response.data)
        const self = this
        self.desserts = response.data
        self.desserts.sort(this.compareId)
        for (let i = 0; i < this.desserts.length; i++) {
          self.desserts.at(i).score = 0
          for (let j = 0; j < this.dataHistory.length; j++) {
            if (self.desserts.at(i).id === self.dataHistory.at(j).id_match) {
              self.desserts.at(i).choose = self.dataHistory.at(j).choose
            }
            if (self.desserts.at(i).id === self.dataHistory.at(j).id_match) {
              self.desserts.at(i).score = self.dataHistory.at(j).score
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
  },
  beforeMount() {
    this.dessertsIt()
    this.dataHistory()
  }
}

</script>
<style rel="stylesheet/scss" lang="scss" scoped>
@import "src/assets/main.scss";
</style>
