<template>
    <section class="gradient-custom">
        <div class="container my-5 py-5">
            <div class="row d-flex justify-content-center">
                <div class="col-md-12 col-lg-10 col-xl-8">
                    <div class="card">
                        <div class="card-body p-4">
                            <h4 class="text-center mb-4 pb-2">Commentaires</h4>

                            <div class="row">
                                <div class="col">
                                    <div :class="key == 0  ? 'd-flex flex-start' :  'd-flex flex-start mt-4'" v-for="( comment , key ) in comments " :key="comment.id">
                                        <img class="rounded-circle shadow-1-strong me-3"
                                            :src="comment.image" alt="avatar"
                                            width="65" height="65" />
                                        <div class="flex-grow-1 flex-shrink-1">
                                            <div>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <p class="mb-1">
                                                        {{ comment.autor }} <span class="small">- 2 hours ago</span>
                                                    </p>
                                                    <a href="#" @click.prevent="replay(comment , 'comment')"><i class="fas fa-reply fa-xs"></i><span class="small">
                                                            reply</span></a>
                                                </div>
                                                <p class="small mb-0">
                                                    {{ comment.text}}
                                                </p>
                                            </div>

                                            <div class="d-flex flex-start mt-4" v-for="sub_comment in comment.children" :key="sub_comment.id">
                                                <a class="me-3" href="#">
                                                    <img class="rounded-circle shadow-1-strong"
                                                        src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/img%20(11).webp"
                                                        alt="avatar" width="65" height="65" />
                                                </a>
                                                <div class="flex-grow-1 flex-shrink-1">
                                                    <div>
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <p class="mb-1">
                                                                {{ sub_comment.autor }} <span class="small">- 3 hours ago</span>
                                                            </p>
                                                            <a href="#" @click.prevent="replay(comment , 'sub_comment')"><i class="fas fa-reply fa-xs"></i><span class="small">
                                                            reply</span></a>
                                                        </div>
                                                        <p class="small mb-0">
                                                            {{ sub_comment.text}}
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

<script lang="ts">
export default {
    props: ['comments'],
    methods: {
        replay(comment: any, type: string) {
            this.$emit('replay', comment, type)
            window.location.hash = '#form';
        }
    }
}
</script>