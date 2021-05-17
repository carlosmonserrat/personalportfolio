<template lang="html">
  <nav class="menu">
    <ul>
      <li>
        <router-link :to="{ name: 'Home' }">
          <span class="iso-logo" id="logo">$ krloz.dev</span>
        </router-link>
      </li>
      <li><a href="#">EN</a> | <a href="#">ES</a></li>
    </ul>
  </nav>
</template>

<style scoped>
.menu {
  background: #3D3D3D;
  opacity: 0.8;
  color: white;
}

.menu ul {
  display: flex;
  flex-wrap: wrap;
}

.menu ul li {
  font-weight: 300;
  list-style: none;
  padding: 16px 16px 16px 0;
}

.menu a {
  text-decoration: none;
  color: white;
}

.iso-logo {
  color: #4CFF89;
}
</style>
