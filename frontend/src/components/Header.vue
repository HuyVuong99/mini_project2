<template>
  <v-list>
    <v-list-item
        v-for="[icon, text] in home"
        :key="icon" @click="homeVue">
      <v-icon>{{ icon }}</v-icon>
      <v-list-item-title>{{ text }}</v-list-item-title>
    </v-list-item>
    <v-list-item
        v-for="[icon, text] in bets"
        :key="icon"
        @click=bets_user>
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
</template>

<script>
export default {
  name: "Header",
  data: () => ({
    bets: [['mdi-controller', 'Bets']],
    rank: [['mdi-send', 'Ranking']],
    home: [['mdi-home', 'Home']],
    historyBets: [['mdi-card-text', "History Bets"]],
  }),
  methods: {
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
      this.$router.push('/history/' + localStorage.id)
    }
  }
}
</script>

<style scoped>

</style>