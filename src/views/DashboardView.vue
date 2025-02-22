<template>
  <v-container>
    <ExpenseTable
      :expenses="filteredExpenses"
      :searchVendors.sync="searchVendors"
      :searchGLAccount.sync="searchGLAccount"
    />
    <ExpenseChart :expenses="filteredExpenses" />
  </v-container>
</template>

<script>
import data from "@/assets/Task_Data.json";
import ExpenseChart from "@/components/ExpenseChart.vue";
import ExpenseTable from "@/components/ExpenseTable.vue";

export default {
  components: { ExpenseTable, ExpenseChart },
  data() {
    return {
      expenses: data,
      searchVendors: [],
      searchGLAccount: null,
    };
  },
  computed: {
    filteredExpenses() {
      return this.expenses.filter((exp) => {
        const vendorMatch =
          this.searchVendors.length === 0 ||
          this.searchVendors.includes(exp.vendor);

        const glAccountMatch =
          !this.searchGLAccount || exp.gl_account === this.searchGLAccount;

        return vendorMatch && glAccountMatch;
      });
    },
  },
};
</script>
