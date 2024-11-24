<script setup>
import { ref, onMounted } from 'vue';
import { auth } from '../firebase';
import { signOut } from 'firebase/auth';
import { fetchUserData } from '../api/userService';

const props = defineProps({
  user: {
    type: Object,
    required: true
  }
});

const emit = defineEmits(['error']);
const token = ref('');
const userData = ref(null);

onMounted(async () => {
  try {
    token.value = await props.user.getIdToken();
    userData.value = await fetchUserData(token.value);
  } catch (e) {
    emit('error', e.message);
  }
});

const handleSignOut = async () => {
  try {
    await signOut(auth);
    token.value = '';
    userData.value = null;
  } catch (e) {
    emit('error', e.message);
  }
};

const copyToken = async () => {
  try {
    await navigator.clipboard.writeText(token.value);
  } catch (e) {
    emit('error', 'Failed to copy token to clipboard');
  }
};
</script>

<template>
  <div class="profile-section">
    <h2>Welcome, {{ userData?.name || user.displayName || user.email }}!</h2>
    <img 
      v-if="user.photoURL" 
      :src="user.photoURL" 
      alt="Profile" 
      class="profile-pic"
    />
    <p>Email: {{ user.email }}</p>
    
    <div v-if="userData" class="user-data-section">
      <h3>User Attributes:</h3>
      <div class="attributes-container">
        <pre>{{ JSON.stringify(userData.attributes, null, 2) }}</pre>
      </div>
    </div>
    
    <div class="token-section">
      <h3>JWT Token:</h3>
      <div class="token-container">
        <div class="token-text">
          {{ token.slice(0, 20) }}...{{ token.slice(-20) }}
        </div>
        <button @click="copyToken" class="copy-btn">
          Copy Full Token
        </button>
      </div>
    </div>

    <button @click="handleSignOut" class="signout-btn">
      Sign Out
    </button>
  </div>
</template>

<style scoped>
.profile-section {
  margin-top: 2rem;
  padding: 1.5rem;
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  color: #1a1a1a;
}

.profile-pic {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  margin: 1rem 0;
}

.user-data-section {
  margin: 1.5rem 0;
  padding: 1rem;
  background-color: #f8f9fa;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.attributes-container {
  text-align: left;
  background-color: white;
  padding: 1rem;
  border-radius: 4px;
  border: 1px solid #ced4da;
  overflow-x: auto;
}

.attributes-container pre {
  margin: 0;
  color: #1a1a1a;
  font-size: 0.9rem;
}

.token-section {
  margin: 1.5rem 0;
  padding: 1rem;
  background-color: #f8f9fa;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.token-container {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  align-items: center;
}

.token-text {
  font-family: monospace;
  background-color: white;
  padding: 0.75rem;
  border-radius: 4px;
  word-break: break-all;
  font-size: 0.9rem;
  color: #1a1a1a;
  border: 1px solid #ced4da;
}

.copy-btn {
  background-color: #6c757d;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.copy-btn:hover {
  background-color: #5a6268;
}

.signout-btn {
  background-color: #dc3545;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  margin-top: 1rem;
}

.signout-btn:hover {
  background-color: #c82333;
}
</style>