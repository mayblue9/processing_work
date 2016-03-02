public class Easing {
    private EaseType mEasing;

    public Easing() {
        mEasing = EaseType.LINEAR;
    }

    public Easing(EaseType easing) {
        mEasing = easing;
    }

    public float getInterpolation(float elapsedTimeRate) {
        switch (mEasing) {
            case LINEAR:
                return 1f;

            case SINE_IN:
                return (float) (1f - Math.cos(elapsedTimeRate * Math.PI / 2f));

            case SINE_OUT:
                return (float) Math.sin(elapsedTimeRate * Math.PI / 2f);

            case SINE_IN_OUT:
                return (float) (-0.5f * (Math.cos(Math.PI * elapsedTimeRate) - 1f));

            case QUAD_IN:
                return getPowIn(elapsedTimeRate, 2);

            case QUAD_OUT:
                return getPowOut(elapsedTimeRate, 2);

            case QUAD_IN_OUT:
                return getPowInOut(elapsedTimeRate, 2);

            case CUBIC_IN:
                return getPowIn(elapsedTimeRate, 3);

            case CUBIC_OUT:
                return getPowOut(elapsedTimeRate, 3);

            case CUBIC_IN_OUT:
                return getPowInOut(elapsedTimeRate, 3);

            case QUART_IN:
                return getPowIn(elapsedTimeRate, 4);

            case QUART_OUT:
                return getPowOut(elapsedTimeRate, 4);

            case QUART_IN_OUT:
                return getPowInOut(elapsedTimeRate, 4);

            case QUINT_IN:
                return getPowIn(elapsedTimeRate, 5);

            case QUINT_OUT:
                return getPowOut(elapsedTimeRate, 5);

            case QUINT_IN_OUT:
                return getPowInOut(elapsedTimeRate, 5);

            case BACK_IN:
                return (float) (elapsedTimeRate * elapsedTimeRate * ((1.7 + 1f) * elapsedTimeRate - 1.7));

            case BACK_OUT:
                return (float) (--elapsedTimeRate * elapsedTimeRate * ((1.7 + 1f) * elapsedTimeRate + 1.7) + 1f);

            case BACK_IN_OUT:
                return getBackInOut(elapsedTimeRate, 1.7f);

            case EXPO_IN:
                return (float) Math.pow(2, 10 * (elapsedTimeRate - 1));

            case EXPO_OUT:
                return -((float) Math.pow(2, -10 * elapsedTimeRate) + 1);

            case EXPO_IN_OUT:
                if (elapsedTimeRate == 0) {
                    return 0;

                } else if (elapsedTimeRate == 1) {
                    return 1;

                } else if ((elapsedTimeRate /= 0.5f) < 1) {
                    return 0.5f * (float)Math.pow(2, 10 * (elapsedTimeRate - 1));

                } else {
                    return 0.5f * (-(float) Math.pow(2, -10 * --elapsedTimeRate) + 2);
                }

            case CIRC_IN:
                return (float) -(Math.sqrt(1f - elapsedTimeRate * elapsedTimeRate) - 1);

            case CIRC_OUT:
                return (float) Math.sqrt(1f - (--elapsedTimeRate) * elapsedTimeRate);

            case CIRC_IN_OUT:
                if ((elapsedTimeRate *= 2f) < 1f) {
                    return (float) (-0.5f * (Math.sqrt(1f - elapsedTimeRate * elapsedTimeRate) - 1f));
                }
                return (float) (0.5f * (Math.sqrt(1f - (elapsedTimeRate -= 2f) * elapsedTimeRate) + 1f));

            case ELASTIC_IN:
                return getElasticIn(elapsedTimeRate, 1, 0.3);

            case ELASTIC_OUT:
                return getElasticOut(elapsedTimeRate, 1, 0.3);

            case ELASTIC_IN_OUT:
                return getElasticInOut(elapsedTimeRate, 1, 0.45);

            case BOUNCE_IN:
                return getBounceIn(elapsedTimeRate);

            case BOUNCE_OUT:
                return getBounceOut(elapsedTimeRate);

            case BOUNCE_IN_OUT:
                if (elapsedTimeRate < 0.5f) {
                    return getBounceIn(elapsedTimeRate * 2f) * 0.5f;
                }
                return getBounceOut(elapsedTimeRate * 2f - 1f) * 0.5f + 0.5f;

            default:
                return 1f;

        }
    }

    private float getPowIn(float elapsedTimeRate, double pow) {
        return (float) Math.pow(elapsedTimeRate, pow);
    }

    private float getPowOut(float elapsedTimeRate, double pow) {
        return (float) ((float) 1 - Math.pow(1 - elapsedTimeRate, pow));
    }

    private float getPowInOut(float elapsedTimeRate, double pow) {
        if ((elapsedTimeRate *= 2) < 1) {
            return (float) (0.5 * Math.pow(elapsedTimeRate, pow));
        }

        return (float) (1 - 0.5 * Math.abs(Math.pow(2 - elapsedTimeRate, pow)));
    }

    private float getBackInOut(float elapsedTimeRate, float amount) {
        amount *= 1.525;
        if ((elapsedTimeRate *= 2) < 1) {
            return (float) (0.5 * (elapsedTimeRate * elapsedTimeRate * ((amount + 1) * elapsedTimeRate - amount)));
        }

        return (float) (0.5 * ((elapsedTimeRate -= 2) * elapsedTimeRate * ((amount + 1) * elapsedTimeRate + amount) + 2));
    }

    private float getBounceIn(float elapsedTimeRate) {
        return 1f - getBounceOut(1f - elapsedTimeRate);
    }

    private float getBounceOut(float elapsedTimeRate) {
        if (elapsedTimeRate < 1 / 2.75) {
            return (float) (7.5625 * elapsedTimeRate * elapsedTimeRate);

        } else if (elapsedTimeRate < 2 / 2.75) {
            return (float) (7.5625 * (elapsedTimeRate -= 1.5 / 2.75) * elapsedTimeRate + 0.75);

        } else if (elapsedTimeRate < 2.5 / 2.75) {
            return (float) (7.5625 * (elapsedTimeRate -= 2.25 / 2.75) * elapsedTimeRate + 0.9375);

        } else {
            return (float) (7.5625 * (elapsedTimeRate -= 2.625 / 2.75) * elapsedTimeRate + 0.984375);
        }
    }

    private float getElasticIn(float elapsedTimeRate, double amplitude, double period) {
        if (elapsedTimeRate == 0 || elapsedTimeRate == 1) return elapsedTimeRate;
        double pi2 = Math.PI * 2;
        double s = period / pi2 * Math.asin(1 / amplitude);

        return (float) -(amplitude * Math.pow(2f, 10f * (elapsedTimeRate -= 1f)) * Math.sin((elapsedTimeRate - s) * pi2 / period));
    }

    private float getElasticOut(float elapsedTimeRate, double amplitude, double period) {
        if (elapsedTimeRate == 0 || elapsedTimeRate == 1) return elapsedTimeRate;

        double pi2 = Math.PI * 2;
        double s = period / pi2 * Math.asin(1 / amplitude);

        return (float) (amplitude * Math.pow(2, -10 * elapsedTimeRate) * Math.sin((elapsedTimeRate - s) * pi2 / period) + 1);
    }

    private float getElasticInOut(float elapsedTimeRate, double amplitude, double period) {
        double pi2 = Math.PI * 2;

        double s = period / pi2 * Math.asin(1 / amplitude);
        if ((elapsedTimeRate *= 2) < 1) {
            return (float) (-0.5f * (amplitude * Math.pow(2, 10 * (elapsedTimeRate -= 1f)) * Math.sin((elapsedTimeRate - s) * pi2 / period)));
        }

        return (float) (amplitude * Math.pow(2, -10 * (elapsedTimeRate -= 1)) * Math.sin((elapsedTimeRate - s) * pi2 / period) * 0.5 + 1);
    }
}