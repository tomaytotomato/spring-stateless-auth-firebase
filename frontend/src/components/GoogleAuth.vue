<script setup>
import { auth } from '../firebase';
import { GoogleAuthProvider, signInWithPopup } from 'firebase/auth';

const emit = defineEmits(['error']);

const signInWithGoogle = async () => {
  try {
    const provider = new GoogleAuthProvider();
    await signInWithPopup(auth, provider);
  } catch (e) {
    emit('error', e.message);
  }
};
</script>

<template>
  <div class="google-auth">
    <button @click="signInWithGoogle" class="google-btn">
      <img 
        src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg" 
        alt="Google"
        class="google-icon"
      />
      Sign in with Google
    </button>
  </div>
</template>

<style scoped>
.google-auth {
  margin: 1rem 0;
}

.google-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  background-color: white;
  color: #757575;
  border: 1px solid #dadce0;
  padding: 12px 24px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
  margin: 0 auto;
}

.google-btn:hover {
  background-color: #f8f9fa;
}

.google-icon {
  width: 18px;
  height: 18px;
}
</style>