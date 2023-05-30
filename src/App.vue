<template>
  <div id="app">
    <div id="wrapper">
      <div id="navbar"> 
      <h1>REST Countries -by Philip Barnes</h1>
      
        <div id="buttonBox">
      <button class ="navbutton" type="button" @click="pagination(-25)">Back</button>
      <button class ="navbutton" type="button" @click="pagination(25)">Next</button>

  <select name="country" class="country_select" >
    <option value="country-name" v-for="item of name_list" :key="item.id" @select="displayinfo(item)">
      {{ item }}
    </option>
  </select> 
  <button class ="navbutton" type="button" @click="$event => reverse_order()">Reverse</button>
  </div>
</div><br>
  <div id="flagdiv">
    <div class="card" v-for="item of items" :key="item.id"  @click="searchinfo(item)">
      <h1>{{ item.name.official}}</h1>
      
        <img :src="item.flags.png" width=350 height = 200 class="flag" /><br>     
        2 character Country Code: <b>{{ item.cca2 }}</b><br>
        3 character Country Code: <b>{{ item.cca3 }}</b><br>      
        International Dialling IDD <b>{{ item.idd.root }}, {{ item.idd.suffixes }}</b>
      </div>
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
      all_countries:[],
      name_list:[],
      index_name_list:[],
      start:0,
    };
  },
  async created() {
    try {
      const res = await axios.get(`https://restcountries.com/v3.1/all?`);
      this.all_countries = res.data;
      for (let i = 0; i < this.all_countries.length; i++) {       
        this.name_list.push(this.all_countries[i].name.common)
        this.index_name_list.push(this.all_countries[i].name.common)
      }
      this.name_list.sort();
      this.pagination(0);
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
    reverse_order(){
      this.name_list.reverse();
      this.pagination(0);
    },
    increment(page){
      this.start += page
    },
    single_country(name){
      console.log(name)
    },
    pagination(page){
      this.items.length = 0;
      this.start += page;
      if(this.start < 0){this.start = 0}
      if(this.start > this.all_countries.length - 25){this.start = this.all_countries.length-25}
      for (let i = this.start+0; i < this.start+25; i++) {
        this.country_index = this.index_name_list.indexOf(this.name_list[i])
        this.items.push(this.all_countries[this.country_index]); 
      }
    },
    displayinfo(country) {
      console.log(country)     
      var country_string = JSON.stringify(country)
      country_string = this.beautify(country_string)     
      alert(country_string)
    }, 
    searchinfo(country) {
      console.log(country)     
      var country_string = JSON.stringify(country)
      country_string = this.beautify(country_string)     
      alert(country_string)
    },
    beautify(obj){
      obj = obj.replace(/[{}]/g," ")
      obj = obj.replace(/[":"]/g,' ')
      obj = obj.replace(/[,]/g,'\n')
      return obj
    }
  },
};
</script>
<style>
  .card{
    width: 350px;
    height: 400px;
    padding:20px;
    background-color: powderblue;
    margin: 40px;
    border-radius: 30px;
    display:inline-block;
    vertical-align: top;

} 
h1{
  text-align: center;
}
  #wrapper{
    margin: -10px;
}
  .navbutton{
    font-size: 30px;
    padding:15px;
    margin-left: 40px;
    background-color: aliceblue;
    border-radius: 30px;
  }
  select{
    font-size: 30px;
    padding:15px;
    width:500px;
    margin: 20px;
    margin-left: 40px;
    background-color: aliceblue;
    border-radius: 30px;
  }
#navbar{
  background-image: linear-gradient(lightblue 33%, blue);
  position: fixed;
  top: 0; 
  width: 100%; 
  margin-bottom:20px;
  margin-top: 0px;
  padding-left: 40px;
  z-index: 2;
}
  #buttonBox{
    margin: auto;
  }
  #flagdiv{
    position: relative;
    margin-top: 150px;
    padding-top: 25px;
  }
</style>
