# This script takes care of testing your crate

set -ex

main() {
    cross build --features "serde repr_simd" --target $TARGET
    cross build --features "serde repr_simd" --target $TARGET --release

    if [ ! -z $DISABLE_TESTS ]; then
        return
    fi

    cross test --features "serde repr_simd" --target $TARGET
    cross test --features "serde repr_simd" --target $TARGET --release
    #if [ ! $AVOID_DOC_TESTS ]; then
    #    cross test --doc --no-fail-fast --target $TARGET
    #    cross test --doc --no-fail-fast --target $TARGET --release
    #fi

    #cross test --lib --no-fail-fast --target $TARGET
    #cross test --lib --no-fail-fast --target $TARGET --release

    #cross run --target $TARGET
    #cross run --target $TARGET --release
}

# we don't run the "test phase" when doing deploys
if [ -z $TRAVIS_TAG ]; then
    main
fi
