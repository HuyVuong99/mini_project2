<template>
  <v-app id="inspire">
    <v-system-bar app>
    </v-system-bar>
    <v-navigation-drawer
        v-model="drawer"
        app>
      <v-sheet
          color="grey lighten-4"
          class="pa-4"
      >
        <v-avatar
            class="mb-4"
            color="primary"
            size="64"
        ></v-avatar>

        <div>{{ infor }}</div>

        <div>My Score: {{ myScore }}</div>

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
        <v-card-title> My Bets
          <v-spacer></v-spacer>
        </v-card-title>
      </v-container>
      <v-simple-table>
        <template v-slot:default
                  class="elevation-20">
          <thead>
          <tr>
            <th class="text-center">
              Date_Time
            </th>
            <th class="text-center">
              Home_Team
            </th>
            <th class="text-center">
            </th>
            <th class="text-center">
              Away_Team
            </th>
            <th class="text-center">
              Choose
            </th>
            <th class="text-center">
              Bets
            </th>
          </tr>
          </thead>
          <tbody>
          <tr
              v-for="(item) in desserts"
              :key="item.username"
              class="text-center"
              v-if="item.goal === '-' "
              v-bind:class="{first: (item.goal === '-')}">

            <td>{{ item.date_time }}</td>
            <td>{{ item.home_team }}</td>
            <td>{{ item.goal }}</td>
            <td>{{ item.away_team }}</td>
            <td>{{ item.choose }}</td>
            <td>
              <v-btn
                  color="pink"
                  dark
                  class="mb-lg-0"
                  @click="editItem(item)"
              >Bets
              </v-btn>
            </td>
            <v-dialog v-model="dialog"
                      max-width="500px" persistent :retain-focus="false">
              <template v-slot:activator="{ on, attrs }">
              </template>
              <v-card>
                <v-card-title>
                  <span class="text-h5">Your Bets</span>
                </v-card-title>

                <v-card-text>
                  <v-container>
                    <v-row>
                      <v-col
                          cols="12"
                          sm="6"
                          md="4">
                        <v-text-field
                            disabled v-model="editData.home_team"
                            label="Home_Team"
                        ></v-text-field>
                      </v-col>
                      <v-col
                          cols="12"
                          sm="6"
                          md="4"
                      >
                        <v-text-field
                            disabled v-model="editData.away_team"
                            label="Away_Team"
                        ></v-text-field>
                      </v-col>
                      <v-col
                          cols="12"
                          sm="6"
                          md="4"
                      >
                        <v-text-field
                            v-model="editData.choose"
                            label="You choose W,D,L)"
                        ></v-text-field>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn
                      color="red darken-1"
                      text
                      @click="close"
                  >
                    Cancel
                  </v-btn>
                  <v-btn
                      color="blue darken-1"
                      text
                      @click="save(editData)">
                    Save
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>

          </tr>
          </tbody>
        </template>

      </v-simple-table>
    </v-main>
    <v-main>
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
//     const response= await axios.get('http://localhost:1600/matches')
//           console.log(response.data)
//     }
//     return [response]
//
//
//   }
// })
import axios from "axios";
import loginVue from "@/components/LoginVue";
import historyBets from "@/App";

export default {
  data: () => ({
    drawer: null,
    bets: [['mdi-controller', 'Bets']],
    rank: [['mdi-send', 'Ranking']],
    home: [['mdi-home', 'Home']],
    historyBets: [['mdi-card-text', "History Bets"]],
    search: "",
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
    userBets: {
      match_number: undefined,
      date_time: undefined,
      home_team: undefined,
      away_team: undefined,
      id_match: undefined,
      email: localStorage.email,
      username: localStorage.name,
      choose: undefined
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
    save(item) {
      this.userBets.away_team = item.away_team
      this.userBets.home_team = item.home_team
      this.userBets.date_time = item.date_time
      this.userBets.match_number = item.match_number
      this.userBets.id_match = item.id
      this.userBets.choose = item.choose
      axios.put('103.170.123.206:1600/products/users/bets', this.userBets)
      this.close()
    },
    async dessertsIt() {
      this.emailUser.email = localStorage.email
      await axios.post('103.170.123.206:1600/products/get/users/history', this.emailUser).then(response_history => {
        this.dataHistory = response_history.data
      })
      await axios.get('103.170.123.206:1600/products/match').then(response => {
        this.desserts = response.data
        this.desserts.sort(this.compareId)
        for (let i = 0; i < this.desserts.length; i++) {
          for (let j = 0; j < this.dataHistory.length; j++) {
            if (this.desserts.at(i).id === this.dataHistory.at(j).__data__.id_match) {
              this.desserts.at(i).choose = this.dataHistory.at(j).__data__.choose
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
    }
  },
  beforeMount() {
    this.dessertsIt()
  }
}
</script>
<style scoped>
.first {
  background-color: #eedea3
}

.v-data-table > .v-data-table__wrapper > table > tbody > tr > td {
  font-weight: bold;
  font-size: 20px;;
}
</style>
