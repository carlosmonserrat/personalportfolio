<template>
  <Menu/>
  <div class="container">
    <Sections/>
  </div>
</template>

<script>
import Menu from './components/Menu.vue'
import Sections from './components/Sections.vue'

export default {
  name: 'App',
  components: {
    Menu,
    Sections
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
