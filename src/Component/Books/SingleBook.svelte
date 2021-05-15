<script>
    import { onMount } from "svelte";

    export let book;
    let chapters;

    onMount(async function () {
        if (localStorage.getItem(`bookID-${book._id}`)) {
            chapters = JSON.parse(localStorage.getItem(`bookID-${book._id}`));
            return;
        }
        const req = await fetch(
            `${__lotr.env.API_URL}/book/${book._id}/chapter`
        );
        const data = await req.json();
        chapters = data.docs;
        localStorage.setItem(`bookID-${book._id}`, JSON.stringify(chapters));
    });
</script>

<div class="book">
    <div class="title">
        <h2>{book.name}</h2>
    </div>
    {#if chapters != undefined}
        {#await chapters}
            <p>loading</p>
        {:then _}
            <div class="content">
                <ul class="chapters-left">
                    {#each chapters as chap, i}
                        {#if i <= Math.ceil(chapters.length / 2)}
                            <li class="list-item left">{chap.chapterName}</li>
                        {/if}
                    {/each}
                </ul>
                <ul class="chapters-right">
                    {#each chapters as chap, i}
                        {#if i >= Math.ceil(chapters.length / 2)}
                            <li class="list-item right">{chap.chapterName}</li>
                        {/if}
                    {/each}
                </ul>
            </div>
        {/await}
    {/if}
</div>

<style type="text/scss">
    .book {
        margin-bottom: 2rem;
        @media screen and (min-width: 768px) {
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: calc(100vh - 65px);
            min-height: fit-content;
            margin-bottom: 0;
        }
        h2 {
            margin: 0 0 2rem 0;
            padding-bottom: 2rem;
            animation: 1s ease-in-out slideUp;
            animation-delay: 1s;
            opacity: 0;
            animation-fill-mode: forwards;
        }
    }
    .content {
        display: grid;
        grid-template-columns: repeat(1, 1fr);
        max-width: fit-content;
        animation: 1s ease-in-out slideUp;
        animation-delay: 1.5s;
        opacity: 0;
        animation-fill-mode: forwards;
        @media (min-width: 768px) {
            max-width: unset;
            grid-template-columns: repeat(2, 1fr);
            grid-gap: 2rem;
        }
        ul {
            margin: 0;
            text-align: left;
            @media (min-width: 768px) {
                &.chapters-left {
                    text-align: left;
                    grid-column: 1;
                }
                &.chapters-right {
                    text-align: right;
                    grid-column: 2;
                }
            }
        }
    }

    @keyframes slideUp {
        from {
            transform: translateY(5rem);
            opacity: 0;
        }
        to {
            transform: translateY(0);
            opacity: 1;
        }
    }
</style>
