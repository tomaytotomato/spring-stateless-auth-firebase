<script setup>
import { ref } from 'vue';
import { auth } from '../firebase';
import { createUserWithEmailAndPassword, signInWithEmailAndPassword } from 'firebase/auth';

const email = ref('');
const password = ref('');
const isRegistering = ref(false);
const error = ref('');

const handleSubmit = async () => {
  try {
    if (isRegistering.value) {
      await createUserWithEmailAndPassword(auth, email.value, password.value);
    } else {
      await signInWithEmailAndPassword(auth, email.value, password.value);
    }
    email.value = '';
    password.value = '';
    error.value = '';
  } catch (e) {
    error.value = e.message;
  }
};
</script>

<template>
  <div class="basic-auth">
    <h3>{{ isRegistering ? 'Register' : 'Login' }} with Email</h3>
    <form @submit.prevent="handleSubmit" class="auth-form">
      <input
        v-model="email"
        type="email"
        placeholder="Email"
        required
        class="auth-input"
      />
      <input
        v-model="password"
        type="password"
        placeholder="Password"
        required
        class="auth-input"
      />
      <button type="submit" class="auth-button">
        {{ isRegistering ? 'Register' : 'Login' }}
      </button>
    </form>
    <p class="toggle-text">
      {{ isRegistering ? 'Already have an account?' : "Don't have an account?" }}
      <button 
        @click="isRegistering = !isRegistering"
        class="toggle-button"
      >
        {{ isRegistering ? 'Login' : 'Register' }}
      </button>
    </p>
    <p v-if="error" class="error">{{ error }}</p>
  </div>
</template>

<style scoped>
.basic-auth {
  margin: 2rem 0;
  padding: 1.5rem;
  border-radius: 8px;
  background-color: white;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.auth-form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  max-width: 300px;
  margin: 0 auto;
}

.auth-input {
  padding: 8px 12px;
  border: 1px solid #ced4da;
  border-radius: 4px;
  font-size: 16px;
  background-color: white;
  color: #1a1a1a;
}

.auth-input::placeholder {
  color: #6c757d;
}

.auth-button {
  background-color: #4285f4;
  color: white;
  border: none;
  padding: 10px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}

.auth-button:hover {
  background-color: #357abd;
}

.toggle-text {
  margin-top: 1rem;
  font-size: 14px;
  color: #4a5568;
}

.toggle-button {
  background: none;
  border: none;
  color: #4285f4;
  cursor: pointer;
  padding: 0;
  font-size: 14px;
  margin-left: 5px;
}

.toggle-button:hover {
  text-decoration: underline;
}

.error {
  color: #dc3545;
  font-size: 14px;
  margin-top: 0.5rem;
}
</style>