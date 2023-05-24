<template>
  <div id="app">
    <h1>REST Countries</h1>
    <label for="countries">Choose a Country:</label><br>

<select name="country" id="country">
  <option value="country-name" v-for="item of items" :key="item.id">
    {{ item.name.common }}
  </option>
</select> 

  <ul>
    <li v-for="item of items" :key="item.id">
      <h3>{{ item.name.official}} </h3>
      <img src="{{ item.flags.png }}" width="70" height="50"><br>
      {{ item.flags.alt }}<br>
      {{ item.cca2 }}<br>
      {{ item.cca3 }}<br>
      
      {{ item.idd.root }}, {{ item.idd.suffixes }}<br>
    </li>
  </ul>
</div>
</template>
<script>
import axios from "axios";
export default {
  name: "App",
  data() {
    return {
      items: [],
      itemName: "",
    };
  },
  async created() {
    try {
      const res = await axios.get(`https://restcountries.com/v3.1/all`);
      this.items = res.data;
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
    async addItem() {
      const res = await axios.post(`https://restcountries.com/v3.1/all`, {
        name: this.itemName,
      });
      this.items = [...this.items, res.data];
      this.itemName = "";
    },
  },
};
</script>
