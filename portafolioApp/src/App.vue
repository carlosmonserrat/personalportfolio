<template>
  <Menu/>
  <div class="container">
 
 

  </div>
</template>

<script>
import Menu from './components/Menu.vue'
import axios from "axios";

export default {
  name: 'App',  data() {
    return {
      sections: []
    }
  },
  components: {
    Menu
  },
  async mounted() {
    this.sections = await this.fetchSections()
  },
  methods: {
    async fetchSections() {
      return await (await axios.get("/mockup/test.json")).data
    }
  }
}
</script>

<style>
body {
  background-color: #2c2c2c;
}

#app {
  font-family: 'Roboto', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.container{

}
</style>
