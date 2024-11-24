<script setup>
import { ref, onMounted } from 'vue';
import { auth } from './firebase';
import { onAuthStateChanged } from 'firebase/auth';
import GoogleAuth from './components/GoogleAuth.vue';
import BasicAuth from './components/BasicAuth.vue';
import UserProfile from './components/UserProfile.vue';

const user = ref(null);
const error = ref('');

onMounted(() => {
  onAuthStateChanged(auth, (currentUser) => {
    user.value = currentUser;
    if (currentUser) error.value = '';
  });
});

const handleError = (message) => {
  error.value = message;
};
</script>

<template>
  <div class="container">
    <h1>Firebase Auth with Spring</h1>
    <p>Stateless Auth with JWT using Firebase and Spring Security</p>
    
    <template v-if="!user">
      <div class="auth-section">
        <BasicAuth />
        <div class="divider">
          <span>or</span>
        </div>
        <GoogleAuth @error="handleError" />
      </div>
    </template>

    <UserProfile 
      v-else 
      :user="user" 
      @error="handleError"
    />

    <p v-if="error" class="error">{{ error }}</p>
  </div>
</template>

<style>
.container {
  max-width: 600px;
  margin: 0 auto;
  padding: 2rem;
  text-align: center;
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.auth-section {
  margin-top: 2rem;
}

.divider {
  display: flex;
  align-items: center;
  text-align: center;
  margin: 1rem 0;
}

.divider::before,
.divider::after {
  content: '';
  flex: 1;
  border-bottom: 1px solid #dee2e6;
}

.divider span {
  padding: 0 1rem;
  color: #6c757d;
  font-size: 14px;
}

.error {
  color: #dc3545;
  margin-top: 1rem;
  font-weight: 500;
}
</style>