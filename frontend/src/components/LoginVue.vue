<template>
  <v-app>
    <v-app-bar app dark color="blue">
      <v-toolbar-title>Wellcome to FootBall Bets</v-toolbar-title>
      <v-spacer></v-spacer>
    </v-app-bar>
        <v-form @submit.prevent="loginVue">
    <v-main>
      <v-card width="500" class="mx-auto mt-9">
        <v-card-title>Login</v-card-title>
        <v-card-text>
          <v-text-field label="Email" prepend-icon="mdi-account-circle" v-model="login.email" required/>
          <v-text-field
              label="Password"
              v-model="login.password"
              type="password"
              prepend-icon="mdi-lock"/>
        </v-card-text>
        <v-card-actions>
          <v-btn type="submit" @click="loginVue" color="info">Login</v-btn>
        </v-card-actions>
      </v-card>
    </v-main>
        </v-form>
  </v-app>
</template>
<script>
import axios from "axios";

// export default defineComponent({
//   async setup() {
//     const email = ref('')
//     const password = ref('')
//     console.log('aaaaa')
//     const login = async () => {
//     const response = await axios.post('http://localhost:1600/signin', {
//         email: email.value,
//         password: password.value
//       })
//       console.log(response)
//     }
//     return {
//       email, password, login
//     }
//   }
// })
import api from '../plugins/url'
export default {
  name: "Login",
  data() {
    return {
      login: {
        email: '',
        password: ''
      },
      error: ''
    }
  },
  methods: {
    async loginVue() {
      const self = this
      try {
      await api.post('/api/users/login', self.login).then(response => {
        if (response.data.code === 200) {
          localStorage.name = response.data.data[0].username
          localStorage.email = response.data.data[0].email
          localStorage.role = response.data.data[0].role
          localStorage.score = response.data.data[0].score
          localStorage.id = response.data.data[0].id
          localStorage.password = response.data.data[0].password
          self.$router.push('/dashboard')

        }
        else {
          self.error='Invalid email/password!'
        }
      })
      }catch (e) {
        this.error='Invalid email/password!'

      }
    }
  }
}
</script>
