<template>
    <div class="container">
        <form @submit.prevent="handelAddComment()" id="form">
            <div class="form-group">
                <input name="" :class="submit && author === '' ? 'form-control is-invalid' : 'form-control'" id=""
                    v-model.trim="author" placeholder="Votre nom" />
                <div class="invalid-feedback" v-if="submit && author === ''">
                    cette champs est requis
                </div>
            </div>
            <div class="form-group">
                <textarea name="" :placeholder="placeholder"
                    :class="submit && message === '' ? 'form-control is-invalid' : 'form-control'" id=""
                    v-model.trim="message"></textarea>
                <div class="invalid-feedback" v-if="submit && message === ''">
                    cette champs est requis
                </div>
            </div>
            <button class="btn btn-primary" @click.prevent="handelAddComment()">Ajouter</button>
        </form>
    </div>
</template>

<script lang="ts">
export default {
    props: ['replay', 'type'],
    data() {
        return {
            message: "",
            author: "",
            placeholder: "Votre comementaire",
            submit: false
        }
    },
    methods: {
        handelAddComment() {
            this.submit = true;
            if (this.author !== '' && this.message !== '') {
                this.$emit('handelAddComment', this.message, this.author, this.replay, this.type)
                this.submit = false;
                this.message = ""
                this.author = ""
                this.placeholder = "Votre comementaire"
            }
        }
    },
    watch: {
        replay: {
            handler(value) {
                if (value) {
                    this.placeholder = `Reponse a ${value.autor}`
                }
            },
            immediate: true
        }
    }
}
</script>