<template>
  <v-container>
    <ExpenseTable
      :expenses="filteredExpenses"
      :searchVendor.sync="searchVendor"
      :searchGL.sync="searchGL"
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
      searchVendor: "",
      searchGL: "",
    };
  },
  computed: {
    filteredExpenses() {
      return this.expenses.filter(
        (exp) =>
          (this.searchVendor
            ? exp.vendor.toLowerCase().includes(this.searchVendor.toLowerCase())
            : true) &&
          (this.searchGL
            ? exp.gl_account.toLowerCase().includes(this.searchGL.toLowerCase())
            : true)
      );
    },
  },
};
</script>
