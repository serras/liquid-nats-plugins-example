# Example repo using GHC plug-ins
## LiquidHaskell and Natural Normalisation

In this repo you can find implementations of lists-that-track-their-length
using [GADTs](https://github.com/serras/liquid-nats-plugins-example/blob/master/src/gadt/Example.hs)
and [LiquidHaskell](https://github.com/serras/liquid-nats-plugins-example/blob/master/src/liquid/Example.hs).
In both cases, they need GHC plug-ins to be enabled for the code to compile:

- The GADT-based version requires [Natural Normalisation](http://hackage.haskell.org/package/ghc-typelits-natnormalise)
  for the `gAppend` implementation to be accepted. Otherwise you need to resort
  to manually encoding natural numbers and proving equalities "by hand".
- The LiquidHaskell version uses its [integration as plug-in](https://ucsd-progsys.github.io/liquidhaskell-blog/2020/08/20/lh-as-a-ghc-plugin.lhs/) available since
  version 0.8.10.2.

## The important bits

The [Cabal file](https://github.com/serras/liquid-nats-plugins-example/blob/master/talk-gadts-lh.cabal)
is the place where plug-ins must be enabled. If you are using Stack, you also
need to add the LiquidHaskell packages to the [`stack.yaml`](https://github.com/serras/liquid-nats-plugins-example/blob/master/stack.yaml)
file (and currently only the `nightly` resolver ships with a compatible
version of GHC).

Regardless of the plug-in you want to enable, you need to change:

- The `build-depends` field, to ask for the corresponding plug-in as a dependency.
  - Natural Normalisation requires `ghc-typelits-natnormalise` only,
  - LiquidHaskell needs `liquidhaskell` and additionally wrapper libraries which
    include refined type information. Almost always you want to replace `base`
    from that field with `liquid-base`.
- The `ghc-options` field, to enable the plug-in at compile time.
  - For Natural Normalisation use `-fplugin=GHC.TypeLits.Normalise`.
  - For LiquidHaskell use `-fplugin=LiquidHaskell`. In this case I also recommend
    to _disable_ the "incomplete patterns" warning, since you may get false
    positives (in fact, we do in this example).