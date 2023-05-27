<template>
  <div id="app">
    <div id="wrapper">
      <h1>REST Countries</h1>
      <button type="button" @click="showflag(25)">
        Central African Republic</button>
<select name="country" id="country">
  <option value="country-name" v-for="item of name_list" :key="item.id">
    {{ item }}
  </option>
</select> <br>


    <div v-for="item of items" :key="item.id" id="country-info">

      

      <h2 type="button" @click="displayinfo(item)">
        {{ item.name.official}}</h2>
      
      <img :src="item.flags.png" width=350 height = 200 class="flag" /><br>     
      2 character Country Code: <b>{{ item.cca2 }}</b><br>
      3 character Country Code: <b>{{ item.cca3 }}</b><br>      
      International Dialling IDD <b>{{ item.idd.root }}, {{ item.idd.suffixes }}</b><br>
    
      
      Native Country Name; {{ item.name.nativeName}}
    </div>
  </div>
</div>
</template>
<script>
import axios from "axios";
export default {
  name: "App",
  data() {
    return {
      items: [],
      ascending: true,
      sortBy: 'alphabetically',
      searchValue: '',
      name_list:[]
    };
  },
  async created() {
    try {
      const res = await axios.get(`https://restcountries.com/v3.1/all`);
      this.items = res.data;
      this.name_list=[]
      //this.c_names = JSON.parse(this.items)
      for (let i = 0; i < this.items.length; i++) {
        
      this.name_list.push(this.items[i].name.official)
      }
      this.name_list.sort()
      console.log(JSON.stringify(this.name_list))
    
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
    displayinfo(country) {      
      alert(JSON.stringify(country))
    },
    showflag(country_id){
      this.flagbox=this.items[country_id]
      console.log(JSON.stringify(this.flagbox, null, 2))
      
    }
  },
  computed: {
	sortedArray() {
		let filtereditems = JSON.stringify(this.items)
    //let filtereditems = this.items
    console.log(filtereditems.name)
		console.log(filtereditems)
		
    return filtereditems
	}
},
};
</script>
<style>
  #country-info{
    width: 350px;
    padding:20px;
    background-color: powderblue;
    margin: 20px;
    border-radius: 30px;
    border-color: blueviolet;
    border-width: 2px;
    display: inline-block;
} 
  #wrapper{
    background-color: salmon;

}
  .button{
    border: none;
    background-color: lemonchiffon;
    margin:auto;
  }
</style>
