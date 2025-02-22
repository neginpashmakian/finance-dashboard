<template>
  <v-container>
    <v-row>
      <!-- Bar Chart -->
      <v-col cols="12" md="6">
        <v-card class="pa-4 elevation-3">
          <v-card-title>Monthly Expenses (Bar Chart)</v-card-title>
          <v-card-text>
            <canvas ref="barChartCanvas"></canvas>
          </v-card-text>
        </v-card>
      </v-col>

      <!-- Line Chart -->
      <v-col cols="12" md="6">
        <v-card class="pa-4 elevation-3">
          <v-card-title>Expense Trends (Line Chart)</v-card-title>
          <v-card-text>
            <canvas ref="lineChartCanvas"></canvas>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>

    <v-row>
      <!-- Pie Chart -->
      <v-col cols="12">
        <v-card class="pa-4 elevation-3">
          <v-card-title>GL Account Breakdown (Pie Chart)</v-card-title>
          <v-card-text>
            <canvas ref="pieChartCanvas"></canvas>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import Chart from "chart.js/auto";
import { nextTick } from "vue";

export default {
  props: ["expenses"],
  data() {
    return {
      barChart: null,
      lineChart: null,
      pieChart: null,
    };
  },
  watch: {
    expenses: {
      deep: true,
      handler(newData) {
        console.log("Filtered expenses data received:", newData);
        this.renderCharts();
      },
    },
  },
  mounted() {
    nextTick(() => {
      this.renderCharts();
    });
  },
  methods: {
    renderCharts() {
      if (!this.expenses || this.expenses.length === 0) {
        console.warn("No expense data available for the charts!");
        return;
      }

      if (this.barChart) this.barChart.destroy();
      if (this.lineChart) this.lineChart.destroy();
      if (this.pieChart) this.pieChart.destroy();

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
      const glAccountData = {};

      monthLabels.forEach((month) => {
        monthData[month] = 0;
      });

      this.expenses.forEach((exp) => {
        if (Object.prototype.hasOwnProperty.call(monthData, exp.month)) {
          monthData[exp.month] += exp.amount;
        }

        if (!glAccountData[exp.gl_account]) {
          glAccountData[exp.gl_account] = 0;
        }
        glAccountData[exp.gl_account] += exp.amount;
      });

      const ctxBar = this.$refs.barChartCanvas.getContext("2d");
      this.barChart = new Chart(ctxBar, {
        type: "bar",
        data: {
          labels: monthLabels,
          datasets: [
            {
              label: "Expenses (EUR)",
              data: monthLabels.map((month) => monthData[month]),
              backgroundColor: "rgba(54, 162, 235, 0.6)",
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
        },
      });

      const ctxLine = this.$refs.lineChartCanvas.getContext("2d");
      this.lineChart = new Chart(ctxLine, {
        type: "line",
        data: {
          labels: monthLabels,
          datasets: [
            {
              label: "Expense Trends",
              data: monthLabels.map((month) => monthData[month]),
              borderColor: "rgba(255, 99, 132, 1)",
              fill: false,
              tension: 0.4,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
        },
      });

      const ctxPie = this.$refs.pieChartCanvas.getContext("2d");
      this.pieChart = new Chart(ctxPie, {
        type: "pie",
        data: {
          labels: Object.keys(glAccountData),
          datasets: [
            {
              data: Object.values(glAccountData),
              backgroundColor: ["#3b82f6", "#f97316", "#14b8a6", "#eab308"],
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
        },
      });

      console.log("Charts updated successfully!");
    },
  },
};
</script>
