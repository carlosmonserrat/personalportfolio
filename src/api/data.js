import axios from 'axios';

export async function getData() {
    let data = [];
    const response = await axios.get(`../mockup/data.json`);
    data = response.data;
    return data;
}
