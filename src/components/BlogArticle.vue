<template lang="html">
  <div class="row">
    <section
        class="sections col-sm-6"
        v-for="section in sections"
        :key="section.id">
      <h3>{{ section.category }}</h3>
      <img class="section-picture" :src="section.pictureUrl" alt="">
      <h3>{{ section.category }}</h3>
    </section>
  </div>
</template>

<script lang="js">

export default {
  name: 'sections',
  props: {
    sections: Object
  }
}

</script>

<style scoped>
.sections {
  color: white;
}

.section-picture {
  width: 40%;
}
</style>
