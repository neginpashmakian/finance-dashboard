<template>
  <v-app :dark="darkMode">
    <v-app-bar app :color="darkMode ? 'grey darken-4' : 'blue darken-3'" dark>
      <v-toolbar-title>Kiresult Dashboard</v-toolbar-title>
      <v-spacer></v-spacer>

      <!-- Dark Mode Toggle -->
      <v-switch
        v-model="darkMode"
        inset
        hide-details
        label="Dark Mode"
        @change="toggleTheme"
      ></v-switch>
    </v-app-bar>

    <!-- Main Content -->
    <v-main>
      <v-container>
        <DashboardView :darkMode="darkMode" />
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import DashboardView from "@/views/DashboardView.vue";

export default {
  components: { DashboardView },
  data() {
    return {
      darkMode: localStorage.getItem("darkMode") === "true",
    };
  },
  watch: {
    darkMode(value) {
      localStorage.setItem("darkMode", value);
    },
  },
  methods: {
    toggleTheme() {
      this.$vuetify.theme.dark = this.darkMode;
    },
  },
};
</script>
