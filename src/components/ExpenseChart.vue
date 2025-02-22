<template>
  <v-card class="pa-4 mt-6">
    <v-card-title>Monthly Expenses</v-card-title>
    <v-card-text>
      <canvas ref="chartCanvas"></canvas>
    </v-card-text>
  </v-card>
</template>

<script>
import Chart from "chart.js/auto";
import { nextTick } from "vue";

export default {
  props: ["expenses"],
  data() {
    return {
      chart: null,
    };
  },
  watch: {
    expenses: {
      deep: true,
      handler(newData) {
        console.log("Filtered expenses data received:", newData);
        this.renderChart();
      },
    },
  },
  mounted() {
    nextTick(() => {
      this.renderChart();
    });
  },
  methods: {
    renderChart() {
      if (!this.expenses || this.expenses.length === 0) {
        console.warn("No expense data available for the chart!");
        return;
      }

      if (this.chart) {
        this.chart.destroy();
      }

      const monthLabels = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      ];
      const monthData = {};

      monthLabels.forEach((month) => {
        monthData[month] = 0;
      });

      this.expenses.forEach((exp) => {
        if (Object.prototype.hasOwnProperty.call(monthData, exp.month)) {
          monthData[exp.month] += exp.amount;
        }
      });

      const ctx = this.$refs.chartCanvas.getContext("2d");

      this.chart = new Chart(ctx, {
        type: "bar",
        data: {
          labels: monthLabels,
          datasets: [
            {
              label: "Expenses (EUR)",
              data: monthLabels.map((month) => monthData[month]),
              backgroundColor: "rgba(54, 162, 235, 0.6)",
              borderColor: "rgba(54, 162, 235, 1)",
              borderWidth: 1,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            y: {
              beginAtZero: true,
            },
          },
        },
      });

      console.log("Chart updated successfully!");
    },
  },
};
</script>
