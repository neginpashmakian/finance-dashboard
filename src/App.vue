<template>
  <v-app>
    <!-- Navbar -->
    <v-app-bar app color="blue darken-3" dark elevation="4">
      <v-toolbar-title>kiResult Dashboard</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn text>Home</v-btn>
      <v-btn text>Reports</v-btn>
      <v-btn text>Settings</v-btn>
    </v-app-bar>

    <v-main>
      <v-container>
        <DashboardView />
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import DashboardView from "./views/DashboardView.vue";

export default {
  components: { DashboardView },
};
</script>
