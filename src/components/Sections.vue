<template lang="html">

  <section
      class="sections"
      v-for="section in sections"
      v-bind:key="section.id">
    <h3>{{ section.category }}</h3>
  </section>

</template>

<script lang="js">
import axios from 'axios'

export default {
  name: 'sections',
  data() {
    return {
      sections: []
    }
  },
  async mounted() {
    this.sections = await this.fetchSections()
  },
  methods: {
    async fetchSections() {
      return await (await axios.get("/mockup/test.json")).data
    }
  },
  computed: {}
}


</script>

<style scoped>
.sections {
  color: white;
}
</style>
