<template>
  <v-container>
    <!-- Filters -->
    <v-card class="pa-4 mb-6 elevation-2">
      <v-card-title>Filter Expenses</v-card-title>
      <v-card-text>
        <v-row>
          <v-col cols="12" md="6">
            <v-text-field
              :value="searchVendor"
              label="Filter by Vendor"
              clearable
              outlined
              dense
              color="blue"
              @input="$emit('update:searchVendor', $event)"
            ></v-text-field>
          </v-col>
          <v-col cols="12" md="6">
            <v-select
              :value="searchGL"
              label="Filter by GL Account"
              :items="uniqueGLAccounts"
              clearable
              outlined
              dense
              color="blue"
              @change="$emit('update:searchGL', $event)"
            ></v-select>
          </v-col>
        </v-row>
      </v-card-text>
    </v-card>

    <!-- Table with Pagination -->
    <v-card elevation="3">
      <v-card-title>Expenses by Vendor</v-card-title>
      <v-card-text>
        <v-data-table
          :headers="headers"
          :items="expenses"
          :items-per-page="5"
          :options.sync="pagination"
          class="elevation-1"
          dense
        >
          <template v-slot:item="{ item, index }">
            <tr
              :style="{
                backgroundColor: index % 2 === 0 ? '#E3F2FD' : '#FFFFFF',
              }"
            >
              <td>{{ item.vendor }}</td>
              <td>{{ item.gl_account }}</td>
              <td class="font-weight-bold blue--text">{{ item.amount }} €</td>
            </tr>
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  props: ["expenses", "searchVendor", "searchGL"],
  data() {
    return {
      pagination: {
        page: 1,
        itemsPerPage: 5, // Ensures pagination works
      },
    };
  },
  computed: {
    headers() {
      return [
        {
          text: "Vendor",
          value: "vendor",
          class: "blue--text font-weight-bold",
        },
        {
          text: "GL Account",
          value: "gl_account",
          class: "blue--text font-weight-bold",
        },
        {
          text: "Total Amount (EUR)",
          value: "amount",
          class: "blue--text font-weight-bold",
        },
      ];
    },
    uniqueGLAccounts() {
      // Extract unique GL Account names for the dropdown
      const glAccounts = new Set(this.expenses.map((exp) => exp.gl_account));
      return Array.from(glAccounts);
    },
  },
};
</script>
