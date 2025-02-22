<template>
  <v-container>
    <!-- Filter Section -->
    <v-card
      class="pa-4 mb-6 elevation-3 filter-card"
      :class="{ 'dark-theme': darkMode }"
    >
      <v-card-title class="blue--text font-weight-bold">
        <v-icon class="mr-2">mdi-filter-variant</v-icon>
        Filter Expenses
      </v-card-title>
      <v-card-text>
        <v-row>
          <!-- Multi-Select for Vendor -->
          <v-col cols="12" md="6">
            <v-autocomplete
              v-model="selectedVendors"
              :items="uniqueVendors"
              label="Filter by Vendors"
              multiple
              outlined
              dense
              clearable
              color="blue"
              prepend-inner-icon="mdi-magnify"
              @change="$emit('update:searchVendors', selectedVendors)"
            ></v-autocomplete>
          </v-col>

          <!-- Dropdown for GL Account -->
          <v-col cols="12" md="6">
            <v-select
              v-model="selectedGLAccount"
              label="Filter by GL Account"
              :items="uniqueGLAccounts"
              clearable
              outlined
              dense
              color="blue"
              prepend-inner-icon="mdi-menu-down"
              @change="$emit('update:searchGLAccount', selectedGLAccount)"
            ></v-select>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>

    <!-- Table Section -->
    <v-card elevation="3" :class="{ 'dark-theme': darkMode }">
      <v-card-title>Expenses by Vendor</v-card-title>
      <v-card-text>
        <v-data-table
          :headers="headers"
          :items="expenses"
          :items-per-page="5"
          :options.sync="pagination"
          class="elevation-1"
          dense
          :class="{ 'dark-table': darkMode }"
        >
          <template v-slot:item="{ item, index }">
            <tr
              :style="{
                backgroundColor: darkMode
                  ? index % 2 === 0
                    ? '#2a2a2a'
                    : '#1e1e1e' /* Darker Gray */
                  : index % 2 === 0
                  ? '#E3F2FD'
                  : '#FFFFFF',
                color: darkMode ? '#e0e0e0' : '#000000',
              }"
            >
              <td>{{ item.vendor }}</td>
              <td>{{ item.gl_account }}</td>
              <td>{{ item.amount }} €</td>
            </tr>
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  props: ["expenses", "searchVendors", "searchGLAccount", "darkMode"],
  data() {
    return {
      selectedVendors: [],
      selectedGLAccount: null,
      pagination: {
        page: 1,
        itemsPerPage: 5,
      },
    };
  },
  computed: {
    headers() {
      return [
        { text: "Vendor", value: "vendor" },
        { text: "GL Account", value: "gl_account" },
        { text: "Amount (EUR)", value: "amount" },
      ];
    },
    uniqueVendors() {
      return Array.from(new Set(this.expenses.map((exp) => exp.vendor)));
    },
    uniqueGLAccounts() {
      return Array.from(new Set(this.expenses.map((exp) => exp.gl_account)));
    },
  },
};
</script>

<style scoped>
/* Dark Theme Styles */
.dark-theme {
  background-color: #121212 !important;
  color: white !important;
}

.dark-table {
  background-color: #1e1e1e !important;
}

tr {
  height: 50px;
}
</style>
