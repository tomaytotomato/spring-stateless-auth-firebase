import axios from 'axios';

const API_URL = 'http://localhost:8080';

export const fetchUserData = async (token) => {
  try {
    const response = await axios.get(`${API_URL}/user`, {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    });
    return response.data;
  } catch (error) {
    throw new Error('Failed to fetch user data');
  }
};