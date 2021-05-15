<script>
</script>

<section class="home">
    <div class="wrapper">
        <div class="background">
            <img src="../assets/home.jpg" alt="land" />
        </div>

        <h1>Lord of the Rings</h1>

        <div class="content">
            <p>
                The Lord of the Rings is an epic high fantasy novel by the
                English author and scholar J. R. R. Tolkien. Set in
                Middle-earth, the world at some distant time in the past, the
                story began as a sequel to Tolkien's 1937 children's book The
                Hobbit, but eventually developed into a much larger work.
                Written in stages between 1937 and 1949, The Lord of the Rings
                is one of the best-selling books ever written, with over 150
                million copies sold.
            </p>
            <p>
                Using <a href="https://the-one-api.dev"><i>The one API</i></a> this
                project referenced datas abouts books and movies, and all characters
                from Tolkien's Universe.
            </p>
        </div>
    </div>
</section>

<style type="text/scss">
    .home {
        width: 100%;
        margin-top: 70px;
        height: calc(100% - 140px);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        z-index: -1;
        img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.2;
            filter: saturate(0.7);
        }
        animation: 1s ease-in-out fadeIn;
    }
    h1 {
        animation: 1s ease-in-out slideUp;
        animation-delay: 1s;
        opacity: 0;
        animation-fill-mode: forwards;
    }
    .content {
        animation: 1s ease-in-out slideUp;
        animation-delay: 1.5s;
        opacity: 0;
        animation-fill-mode: forwards;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
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
